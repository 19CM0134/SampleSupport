//
//  DetailedWorksViewController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/15.
//

import UIKit

class DetailedWorksViewController: UIViewController {
    
    // MARK: - Properties
    
    private let WIDTH = UIScreen.main.bounds.width
    
    private var categoryName = "CategoryName"
    private var artwork = "Artwork"
    private var imageName = "WS000034"
    
    public func setter(categoryName: String, artwork: String, imageName: String) {
        self.categoryName = categoryName
        self.artwork = artwork
        self.imageName = imageName
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let mainView = ImageView(frame: self.view.bounds, imageName: imageName)
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mainView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setNavBar()
    }
    
    // MARK: - Helpers
    
    fileprivate func setNavBar() {
            
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                   width: WIDTH - 110,
                                                   height: 50))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "\(categoryName)\n\(artwork)"
        self.navigationItem.titleView = label
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_back_ios"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(tappedBackBtn))
    }
    
    // MARK: - Selecters
    
    @objc func tappedBackBtn() {
        self.dismiss(animated: true, completion: nil)
    }

}
