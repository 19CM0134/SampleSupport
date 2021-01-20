//
//  MainTabBarController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/13.
//

import UIKit
import CoreNFC

class MainTabBarController: UITabBarController {
    
    var session: NFCNDEFReaderSession?
    
//    private var foundationView: UIView = {
//        let view = UIView()
//
//
//        return view
//    }()
    
    private var button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "nfctagImage"), for: .normal)
        btn.addTarget(self, action: #selector(tappedBtn), for: .touchUpInside)
        
        return btn
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "NFC"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        
        setBtn()
    }
    
    fileprivate func setBtn() {
        view.addSubview(button)
        
        button.setDimensions(width: 20 , height: 20)
        button.anchor(top: tabBar.topAnchor,
                      left: tabBar.leftAnchor,
                      paddingTop: 10,
                      paddingLeft: (UIScreen.main.bounds.width / 2) - 10)
        
        view.addSubview(label)
        label.anchor(top: button.bottomAnchor,
                     left: button.leftAnchor,
                     paddingTop: 5)
    }
    
    fileprivate func showAlert() {
        
        let alertController = UIAlertController(title: "Scanning NFC Tag",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let customView = UIView()
        alertController.view.addSubview(customView)
        customView.anchor(top: alertController.view.topAnchor,
                          left: alertController.view.leftAnchor,
                          right: alertController.view.rightAnchor,
                          paddingTop: 45,
                          paddingLeft: 10,
                          paddingRight: 10,
                          height: 250)
        
        let customText = UITextView()
        customView.addSubview(customText)
        customText.text = "スキャンを開始します"
        customText.textColor = .black
        customText.backgroundColor = .clear
        customText.textAlignment = .center
        customText.anchor(top: customView.topAnchor,
                          left: customView.leftAnchor,
                          right: customView.rightAnchor,
                          paddingTop: 10,
                          paddingLeft: 10,
                          paddingRight: 10,
                          height: 40)
        customText.font = UIFont.systemFont(ofSize: 30)
        
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: 430).isActive = true
        
        
        let selectAction = UIAlertAction(title: "Scan Complete",
                                         style: .default) {
            (action) in
            print("selection")
            let vc = DetailedWorksViewController()
            vc.setter(categoryName: "学生作品", artwork: "ART SCREEN", imageName: "WS000034")
            let nextvc = MainNavigationController(rootViewController: vc)
            nextvc.modalPresentationStyle = .fullScreen
            self.present(nextvc, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func showNFC() {
        
        if NFCNDEFReaderSession.readingAvailable {
        
            session = NFCNDEFReaderSession(delegate: self,
                                           queue: nil,
                                           invalidateAfterFirstRead: false)
            session?.alertMessage = "タグを端末上部に近づけてください"
            session?.begin()
        } else {
            print("NFCが使えません")
        }
    }
    
    @objc func tappedBtn() {
        print("tapped Button")
        
//        showAlert()
        
        showNFC()
        
    }
    
}

extension MainTabBarController: NFCNDEFReaderSessionDelegate {
    // エラーの場合(ユーザがキャンセルを押しても処理される)
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
        print("error: \(error.localizedDescription)")
    }
    // 読み取り完了
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        for msg in messages {
            for record in msg.records {
                print(String(data: record.payload, encoding: .utf8)!)
            }
        }
        
        let vc = DetailedWorksViewController()
        vc.setter(categoryName: "学生作品", artwork: "ART SCREEN", imageName: "WS000034")
        let nextvc = MainNavigationController(rootViewController: vc)
        nextvc.modalPresentationStyle = .fullScreen
        self.present(nextvc, animated: true, completion: nil)
    }
    
    
}
