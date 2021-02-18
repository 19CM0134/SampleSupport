//
//  MainTabBarController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/13.
//

import UIKit
import CoreNFC

enum State {
    case standBy
    case read
    case write
}

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private var session: NFCNDEFReaderSession?
    private var message: NFCNDEFMessage?
    private var state  : State = .standBy
    private var id     : Int!
    private var archive: [String : String] = [:]
    private var storage: [Int] = []
    
    private var button: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "nfcBlack"), for: .normal)
        btn.addTarget(self, action: #selector(tappedBtn), for: .touchUpInside)

        return btn
    }()

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        view.backgroundColor = .white
        setBtn()
    }
    
    // MARK: - Helpers
    
    fileprivate func setBtn() {
        view.addSubview(button)
        button.setDimensions(width: 50 , height: 50)
        button.anchor(top: tabBar.topAnchor,
                      left: tabBar.leftAnchor,
                      paddingLeft: (UIScreen.main.bounds.width / 2) - 25)
        button.layer.cornerRadius = 25
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 1.0
    }
        
    fileprivate func startSession(state: State) {
        self.state = state
        guard NFCNDEFReaderSession.readingAvailable else {
            let alertController = UIAlertController(
                title: "サポートされていません",
                message: "ご使用の端末はサポートされていません",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "タグを端末上部に近づけてください"
        session?.begin()
    }
    
    func stopSession(alert: String = "", error: String = "") {
        session?.alertMessage = alert
        if error.isEmpty {
            session?.invalidate()
        } else {
            session?.invalidate(errorMessage: error)
        }
        self.state = .standBy
    }
    
    func tagRemovalDetect(_ tag: NFCNDEFTag) {
        session?.connect(to: tag) { (error: Error?) in
            if error != nil || !tag.isAvailable {
                self.session?.restartPolling()
                return
            }
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .milliseconds(500), execute: {
                self.tagRemovalDetect(tag)
            })
        }
    }
    
    func updateMessage(_ message: NFCNDEFMessage) -> Bool {
        if message.records.isEmpty { return false }
        var results = [String]()
        for record in message.records {
            if let type = String(data: record.type, encoding: .utf8) {
                if type == "T" { //データ形式がテキストならば
                    let res = record.wellKnownTypeTextPayload()
                    if let text = res.0 {
                        results.append(text)
                    }
                } else if type == "U" { //データ形式がURLならば
                    let res = record.wellKnownTypeURIPayload()
                    if let url = res {
                        results.append("url: \(url)")
                    }
                }
            }
        }
        stopSession(alert: "読み込み成功")
        id = Int(String(results.first!))!
        if storage.isEmpty {
            storage.append(id)
        } else {
            let ans = storage.filter{$0 == id}
            if ans == [] {
                storage.append(id)
            }
        }
        storage.sort()
        UserDefaults.standard.set(storage, forKey: "id")
        print("読み込みID: \(id!)")
        // 時間取得
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd HH:mm", options: 0, locale: Locale(identifier: "ja_jp"))
        print("NFC読み込み時間\(dateFormatter.string(from: date))")
        // 辞書型配列に[id : 日時]を入れる
        archive[String(results.first!)] = dateFormatter.string(from: date)
        UserDefaults.standard.set(archive, forKey: "archive")
        DispatchQueue.main.async {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "detail") as! DetailedWorksViewController
            vc.setter(id: self.id)
            let nextvc = MainNavigationController(rootViewController: vc)
            nextvc.modalPresentationStyle = .fullScreen
            self.present(nextvc, animated: true, completion: nil)
        }
        return true
    }
    
    // MARK: - Selecters
    
    @objc func tappedBtn() {
        startSession(state: .read)
    }
}

// MARK: - NFCNDEFReaderSessionDelegate

extension MainTabBarController: NFCNDEFReaderSessionDelegate {
    
    /// - Tag: sessionBecomeActive
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {}

    /// - Tag: endScanning
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {

        print("error: \(error.localizedDescription)")
        
        // Check the invalidation reason from the returned error.
        if let readerError = error as? NFCReaderError {
            
            if readerError.code == .readerSessionInvalidationErrorSessionTimeout {
                let alertController = UIAlertController(
                    title: "セッションが無効になりました",
                    message: "タイムアウトです\nもう一度お試しください",
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        // To read new tags, a new session instance is required.
        self.session = nil
    }
    
    /// - Tag: processingTagData
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Not Called
    }
    
    /// - Tag: processingNDEFTag
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        
        if tags.count > 1 {
            session.alertMessage = "読み込ませるNFCタグは1枚にしてください"
            tagRemovalDetect(tags.first!)
            return
        }
        let tag = tags.first!
        session.connect(to: tag) { (error) in
            if error != nil {
                session.restartPolling()
                return
            }
        }
        
        tag.queryNDEFStatus { (status, capacity, error) in
            if status == .notSupported {
                self.stopSession(error: "このNFCタグは対応していません")
                return
            }
            if self.state == .read {
                tag.readNDEF { (message, error) in
                    if error != nil || message == nil {
                        self.stopSession(error: error!.localizedDescription)
                        return
                    }
                    if !self.updateMessage(message!) {
                        self.stopSession(error: "このNFCタグは対応していません")
                    }
                }
            }
        }
    }
}
