//
//  FloorMapViewController.swift
//  SampleTabBar
//
//  Created by cmStudent on 2020/12/11.
//

import UIKit

class FloorMapViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak private var menuBtn: UIButton!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let mainView = ImageView(frame: self.view.bounds, imageName: "mapImage")
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mainView)
        
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
        print("Select Menu Button From FloorMapViewController")
        let vc = MenuViewController()
        self.present(vc, animated: true, completion: nil)
    }

}
