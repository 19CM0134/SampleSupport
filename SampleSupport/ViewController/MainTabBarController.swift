//
//  MainTabBarController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/13.
//

import UIKit
import CoreNFC

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var session: NFCNDEFReaderSession?
    
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
        
    fileprivate func showNFC() {
        guard NFCNDEFReaderSession.readingAvailable else {
            let alertController = UIAlertController(
                title: "Scanning Not Supported",
                message: "This device doesn't support tag scanning.",
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
    
//   // MARK: - Selecters
    
    @objc func tappedBtn() {
        print("tapped Button")
        showNFC()
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
            
            // Show an alert when the invalidation reason is not because of a
            // successful read during a single-tag read session, or because the
            // user canceled a multiple-tag read session from the UI or
            // programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(
                    title: "Session Invalidated",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            } else if readerError.code == .readerSessionInvalidationErrorSessionTimeout {
                // タイムアウト
            } else if readerError.code == .readerSessionInvalidationErrorUserCanceled {
                print(".readerSessionInvalidationErrorUserCanceled: \(readerError.code)")
                // キャンセル
            }
        }

        // To read new tags, a new session instance is required.
        self.session = nil
    }
    
    /// - Tag: processingTagData
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        print("success")
        DispatchQueue.main.async {
            let vc = DetailedWorksViewController()
            vc.setter(categoryName: "学生作品", artwork: "ART SCREEN", imageName: "WS000034")
            let nextvc = MainNavigationController(rootViewController: vc)
            nextvc.modalPresentationStyle = .fullScreen
            self.present(nextvc, animated: true, completion: nil)
        }
    }
    
    /// - Tag: processingNDEFTag
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        
        print("didDetect")
        DispatchQueue.main.async {
            let vc = DetailedWorksViewController()
            vc.setter(categoryName: "学生作品", artwork: "ART SCREEN", imageName: "WS000034")
            let nextvc = MainNavigationController(rootViewController: vc)
            nextvc.modalPresentationStyle = .fullScreen
            self.present(nextvc, animated: true, completion: nil)
        }
        session.invalidate()
    }
}
