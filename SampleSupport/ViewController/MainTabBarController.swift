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
    
//    var session: NFCNDEFReaderSession?
    
//    private var button: UIButton = {
//        let btn = UIButton()
//        btn.setBackgroundImage(UIImage(named: "nfcBlack"), for: .normal)
//        btn.addTarget(self, action: #selector(tappedBtn), for: .touchUpInside)
//
//        return btn
//    }()

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        
//        setBtn()
    }
    
    // MARK: - Helpers
    
//    fileprivate func setBtn() {
//        view.addSubview(button)
//
//        button.setDimensions(width: 50 , height: 50)
//        button.anchor(top: tabBar.topAnchor,
//                      left: tabBar.leftAnchor,
//                      paddingLeft: (UIScreen.main.bounds.width / 2) - 25)
//        button.layer.cornerRadius = 25
//        button.backgroundColor = .black
//        button.layer.borderColor = UIColor.darkGray.cgColor
//        button.layer.borderWidth = 1.0
//
//    }
        
//    fileprivate func showNFC() {
//
//        if NFCNDEFReaderSession.readingAvailable {
//
//            session = NFCNDEFReaderSession(delegate: self,
//                                           queue: nil,
//                                           invalidateAfterFirstRead: false)
//            session?.alertMessage = "タグを端末上部に近づけてください"
//            session?.begin()
//        } else {
//            print("NFCが使えません")
//        }
//    }
    
//   // MARK: - Selecters
    
//    @objc func tappedBtn() {
//        print("tapped Button")
//
//        showNFC()
//    }
    
}

// MARK: - NFCNDEFReaderSessionDelegate

//extension MainTabBarController: NFCNDEFReaderSessionDelegate {
//    
//    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
//
//    }
//
//    // エラーの場合(ユーザがキャンセルを押しても処理される)
//    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
//
//        print("error: \(error.localizedDescription)")
//    }
//    // 読み取り完了
//    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
//
//        for msg in messages {
//            for record in msg.records {
//                print(String(data: record.payload, encoding: .utf8)!)
//            }
//        }
//
//        let vc = DetailedWorksViewController()
//        vc.setter(categoryName: "学生作品", artwork: "ART SCREEN", imageName: "WS000034")
//        let nextvc = MainNavigationController(rootViewController: vc)
//        nextvc.modalPresentationStyle = .fullScreen
//        self.present(nextvc, animated: true, completion: nil)
//    }
//}
