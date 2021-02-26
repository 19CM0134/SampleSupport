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
    private var targetExhibition: [ExhibitionModel] = []
    
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
    
    private let rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("前回の展示会", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        btn.backgroundColor = .darkGray
        btn.tag = 1
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
                       width: (Width/5)*2,
                       height: (Width/5)*2)
        leftBtn.layer.cornerRadius = 20
        
        view.addSubview(rightBtn)
        rightBtn.anchor(top: leftBtn.topAnchor,
                        left: leftBtn.rightAnchor,
                        paddingLeft: Width/15,
                        width: (Width/5)*2,
                        height: (Width/5)*2)
        rightBtn.layer.cornerRadius = 20
    }
    
    // MARK: - Selecters
    
    @objc func tappedBtnAction(sender: UIButton) {
        if sender.tag == 0 {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "qrcode") as! QRcodeReaderViewController
            self.present(vc, animated: true, completion: nil)
        } else if sender.tag == 1 {
            guard let url = try? FileManager.default.url(for: .documentDirectory,
                                                         in: .userDomainMask,
                                                         appropriateFor: nil,
                                                         create: false)
                    .appendingPathComponent("exhibition.json") else {return}
            do {
                let data = try Data(contentsOf: url)
                self.targetExhibition = try JSONDecoder().decode([ExhibitionModel].self, from: data)
                print("DataDownload: exhibition.jsonファイルが存在します")
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(identifier: "tab") as! MainTabBarController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } catch {
                print(error)
                let alertController = UIAlertController(
                    title: "前回の展示会の履歴が存在しません",
                    message: "QRcodeで展示会情報を読み取ってください",
                    preferredStyle: .alert)
                alertController.addAction(UIAlertAction(
                                            title: "OK",
                                            style: .default,
                                            handler: {_ in
                                                return
                                            }))
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            print("no tag number")
        }
    }
}
