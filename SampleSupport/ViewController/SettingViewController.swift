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
    
    private let category = ["何か"]
    private let WIDTH = UIScreen.main.bounds.width

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        label.text = "設定"
        label.textAlignment = .center
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
                          paddingTop: 15,
                          paddingLeft: WIDTH / 2 - 50)
        
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
            print("switch on")
        } else {
            print("switch off")
        }
    }
}
