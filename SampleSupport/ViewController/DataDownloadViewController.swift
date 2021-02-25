//
//  DataDownloadViewController.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/19.
//

import UIKit

class DataDownloadViewController: UIViewController {
    
    // MARK: - Properties
    
    private let Width  = UIScreen.main.bounds.width
    private let Height = UIScreen.main.bounds.height
    
    private var exhibition: [ExhibitionModel]?
    private var category  : [CategoryModel]?
    private var works     : [WorksModel]?
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "jec")
        
        return image
    }()
    
    private let leftBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("QRcode", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.backgroundColor = .darkGray
        btn.tag = 0
        btn.addTarget(self, action: #selector(tappedBtnAction(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        recognitionUI()
    }
    
    // MARK: - Helpers
    
    private func recognitionUI() {
        
        view.addSubview(iconImage)
        iconImage.setDimensions(width: Width / 2, height: Width / 2)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         paddingTop: Height/8,
                         paddingLeft: Width/4)
        
        view.addSubview(leftBtn)
        leftBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       left: view.leftAnchor,
                       paddingTop: Height/2,
                       paddingLeft: Width/15,
                       paddingRight: Width/15,
                       width: (Width - Width/7.5),
                       height: (Width/5)*2)
        leftBtn.layer.cornerRadius = 20
    }
    
    // MARK: - Selecters
    
    @objc func tappedBtnAction(sender: UIButton) {
        if sender.tag == 0 {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "qrcode") as! QRcodeReaderViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            print("no tag number")
        }
    }
}
