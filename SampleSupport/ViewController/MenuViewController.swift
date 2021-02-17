//
//  MenuViewController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/13.
//

import UIKit
// TODO: ヘルプボタン実装
class MenuViewController: UIViewController {
    
    // MARK: - Properties
    
    private let Width  = UIScreen.main.bounds.width
    private let Height = UIScreen.main.bounds.height
    
    private var backButton: UIButton = {
       let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(tappedBackBtn), for: .touchUpInside)
        
        return btn
    }()
    
    private var btnArray: [UIButton] = []
    
    private var button1: UIButton = {
       let btn = UIButton()
        btn.setTitle("設定", for: .normal)
        
        return btn
    }()
    
    private var button2: UIButton = {
       let btn = UIButton()
        btn.setTitle("履歴", for: .normal)
        
        return btn
    }()
    
    private var button3: UIButton = {
       let btn = UIButton()
        btn.setTitle("アンケート", for: .normal)
        
        return btn
    }()
    
    private var button4: UIButton = {
        let btn = UIButton()
        btn.setTitle("ヘルプ", for: .normal)
        
        return btn
    }()
    
    private var button5: UIButton = {
        let btn = UIButton()
        btn.setTitle("button5", for: .normal)
        
        return btn
    }()
    
    private var button6: UIButton = {
        let btn = UIButton()
        btn.setTitle("button6", for: .normal)
        
        return btn
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

       recognitionUI()
    }
    
    // MARK: - Helpers
    
    fileprivate func recognitionUI() {
        
        view.backgroundColor = .clear
        view.alpha = 1
        btnArray = [button1, button2, button3, button4, button5, button6]
        for i in 0..<btnArray.count {
            btnArray[i].layer.cornerRadius = 20
            btnArray[i].setTitleColor(.black, for: .normal)
            btnArray[i].backgroundColor = .white
            btnArray[i].tag = i
            btnArray[i].addTarget(self, action: #selector(tappedBtn(sender:)), for: .touchUpInside)
        }
        
        let stack = UIStackView(arrangedSubviews: [button1, button2, button3])
        view.addSubview(stack)
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = Width / 25
        stack.setDimensions(width: Width - 30, height: (Width - 60) / 3)
        stack.anchor(top: view.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: Height / 3,
                     paddingLeft: Width / 25,
                     paddingRight: Width / 25)
        
        let stack2 = UIStackView(arrangedSubviews: [button4, button5, button6])
        view.addSubview(stack2)
        stack2.axis = .horizontal
        stack2.translatesAutoresizingMaskIntoConstraints = false
        stack2.distribution = .fillEqually
        stack2.alignment = .fill
        stack2.spacing = Width / 25
        stack2.setDimensions(width: Width - 30, height: (Width - 60) / 3)
        stack2.anchor(top: stack.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: Width / 25,
                     paddingLeft: Width / 25,
                     paddingRight: Width / 25)
        button5.alpha = 0.0
        button6.alpha = 0.0
        
        view.addSubview(backButton)
        backButton.setDimensions(width: 40, height: 40)
        backButton.anchor(left: view.leftAnchor,
                          bottom: stack.topAnchor,
                          paddingLeft: 25,
                          paddingBottom: 25)
    }
    
    // MARK: - Selecter
    
    @objc func tappedBtn(sender: UIButton) {
        if sender.tag == 0 {
            print("tapped 設定")
            let vc = SettingViewController()
            present(vc, animated: true, completion: nil)
        } else if sender.tag == 1 {
            print("tapped 履歴")
            let vc = ArchiveViewController()
            present(vc, animated: true, completion: nil)
        } else if sender.tag == 2 {
            print("tapped アンケート")
            
            let url = URL(string: "https://forms.gle/L6pjycxa5esnwKcq9")!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            
        } else if sender.tag == 3 {
            print("tapped ヘルプ")
            let alertController = UIAlertController(title: "ヘルプボタンが押されました",
                                                    message: "このボタンは未実装のヘルプ画面に遷移するためのボタンです", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK",
                                                    style: .default,
                                                    handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            print("No sender tag number")
        }
    }
    
    @objc func tappedBackBtn() {
        print("tapped Back Button")
        self.dismiss(animated: true, completion: nil)
    }
}
