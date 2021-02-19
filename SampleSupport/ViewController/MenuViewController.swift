//
//  MenuViewController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/13.
//

import UIKit

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
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

       recognitionUI()
    }
    
    // MARK: - Helpers
    
    fileprivate func recognitionUI() {
        view.backgroundColor = .clear
        view.alpha = 1
        btnArray = [button1, button2]
        for i in 0..<btnArray.count {
            btnArray[i].layer.cornerRadius = 20
            btnArray[i].setTitleColor(.black, for: .normal)
            btnArray[i].titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
            btnArray[i].backgroundColor = .white
            btnArray[i].tag = i
            btnArray[i].addTarget(self, action: #selector(tappedBtn(sender:)), for: .touchUpInside)
        }
        let stack = UIStackView(arrangedSubviews: [button1, button2])
        view.addSubview(stack)
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = Width / 15
        let pad = (Width / 15) * 2
        let space = (Width / 15) * 3
        stack.setDimensions(width: Width - pad, height: (Width - space) / 2)
        stack.anchor(top: view.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: Height / 3,
                     paddingLeft: Width / 15,
                     paddingRight: Width / 15)
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
            let vc = SettingViewController()
            present(vc, animated: true, completion: nil)
        } else if sender.tag == 1 {
            if UserDefaults.standard.dictionary(forKey: "archive") != nil {
                let vc = ArchiveViewController()
                present(vc, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "履歴がありません",
                                                        message: "タグを読み込んでください",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK",
                                                        style: .default,
                                                        handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        } else {
            print("No sender tag number")
        }
    }
    
    @objc func tappedBackBtn() {
        self.dismiss(animated: true, completion: nil)
    }
}
