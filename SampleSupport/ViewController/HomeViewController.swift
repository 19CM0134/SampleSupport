//
//  HomeViewController.swift
//  SampleTabBar
//
//  Created by cmStudent on 2020/12/11.
//

import UIKit
import CoreNFC

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak private var menuBtn: UIButton!
    
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

        view.backgroundColor = .white
        let mainView = TopImageView(frame: self.view.bounds, imageName: "topImage")
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mainView)
        
        recognitionUI()
    }
    
    // MARK: - Helpers
    
    fileprivate func recognitionUI() {
        
        menuBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuBtn.tintColor = .black
        menuBtn.addTarget(self, action: #selector(tappedMenuBtn), for: .touchUpInside)
        
        setBtn()
    }
    
    fileprivate func setBtn() {
        view.addSubview(button)
        
        button.setDimensions(width: 50 , height: 50)
        button.anchor(left: view.leftAnchor,
                      bottom: view.bottomAnchor,
                      paddingLeft: (UIScreen.main.bounds.width / 2) - 25,
                      paddingBottom: 83)
        button.layer.cornerRadius = 25
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 1.0
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
    
    // MARK: - Selecters
    
    @objc func tappedMenuBtn() {
        print("Select Menu Button From HomeViewController")
        let vc = MenuViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func tappedBtn() {
        print("tapped Button")

        showNFC()
    }
}

extension HomeViewController: NFCNDEFReaderSessionDelegate {
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {

    }

    // エラーの場合(ユーザがキャンセルを押しても処理される)
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {

        print("error: \(error.localizedDescription)")
    }
    // 読み取り完了
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        print("success")

//        for msg in messages {
//            for record in msg.records {
//                print(String(data: record.payload, encoding: .utf8)!)
//            }
//        }

//        let vc = DetailedWorksViewController()
//        vc.setter(categoryName: "学生作品", artwork: "ART SCREEN", imageName: "WS000034")
//        let nextvc = MainNavigationController(rootViewController: vc)
//        nextvc.modalPresentationStyle = .fullScreen
//        self.present(nextvc, animated: true, completion: nil)
    }
}
