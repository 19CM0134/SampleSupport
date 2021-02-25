//
//  SettingViewController.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/12.
//

import UIKit

// 設定画面
class SettingViewController: UIViewController {
    
    // MARK: -  Properties
    
    private let category = ["履歴の削除"]
    private let WIDTH = UIScreen.main.bounds.width
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        label.text = "設定"
        label.textAlignment = .left
        label.setDimensions(width: 100, height: 50)
        
        return label
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        
        return label
    }()
    
    private let swichBtn: UISwitch = {
        let sb = UISwitch()
        sb.addTarget(self, action: #selector(changeSwitch(sender:)),
                     for: .valueChanged)
        sb.isOn = false
        
        return sb
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        recognitionUI()
    }
    
    // MARK: - Helpers
    
    fileprivate func recognitionUI() {
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingTop: 20,
                          paddingLeft: 15)
        
        let stack = UIStackView(arrangedSubviews: [categoryName, swichBtn])
        view.addSubview(stack)
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
        stack.alignment = .bottom
        stack.setDimensions(width: WIDTH - 30, height: 50)
        stack.anchor(top: titleLabel.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 25,
                     paddingLeft: 15,
                     paddingRight: 15)
        categoryName.text = category[0]
    }
    
    // MARK: - Handlers
    
    @objc func changeSwitch(sender: UISwitch) {
        
        if sender.isOn {
            let alertController = UIAlertController(title: "履歴を削除します",
                                                    message: "本当によろしいですか？",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(
                                        title: "OK",
                                        style: .default,
                                        handler: {_ in
                                            UserDefaults.standard.removeObject(forKey: "archive")
                                            UserDefaults.standard.removeObject(forKey: "id")
                                            let dialog = UIAlertController(title: "削除しました",
                                                                           message: "",
                                                                           preferredStyle: .alert)
                                            dialog.addAction(UIAlertAction(title: "OK",
                                                                           style: .default,
                                                                           handler: {_ in
                                                                            self.swichBtn.isOn = false
                                                                           }))
                                            self.present(dialog, animated: true, completion: nil)
                                        }))
            alertController.addAction(UIAlertAction(
                                        title: "NO",
                                        style: .cancel,
                                        handler: {_ in
                                            self.swichBtn.isOn = false
                                        }))
            present(alertController, animated: true, completion: nil)
        } else {
            print("switch off")
        }
    }
}
