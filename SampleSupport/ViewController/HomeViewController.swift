//
//  HomeViewController.swift
//  SampleTabBar
//
//  Created by cmStudent on 2020/12/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak private var menuBtn: UIButton!
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.image = UIImage(named: "apuri_TOP")
        imageView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
        
        recognitionUI()
    }
    
    // MARK: - Helpers
    
    fileprivate func recognitionUI() {
        
        menuBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuBtn.tintColor = .black
        menuBtn.addTarget(self, action: #selector(tappedMenuBtn), for: .touchUpInside)
    }
    
    // MARK: - Selecters
    
    @objc func tappedMenuBtn() {
        print("Select Menu Button From HomeViewController")
        let vc = MenuViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
