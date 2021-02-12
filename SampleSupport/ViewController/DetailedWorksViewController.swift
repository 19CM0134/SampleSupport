//
//  DetailedWorksViewController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/15.
//

import UIKit

class DetailedWorksViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    private let WIDTH = UIScreen.main.bounds.width
    @IBOutlet weak var scrollView: UIScrollView!
    var image: UIImage? = nil
    var imageUrl: String = ""
    var imageView = UIImageView()
    
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
        
        self.scrollView.delegate = self
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,
                          paddingTop: 88)
        
        imageView.image = UIImage(named: imageName)
        scrollView.addSubview(imageView)
        self.imageView.backgroundColor = .white
        self.imageView.contentMode = .scaleAspectFit
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setNavBar()
        
        self.imageView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: scrollView.frame.width,
                                      height: scrollView.frame.height)
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // ズーム終了時の処理
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        // ズーム開始時の処理
    }
    
    func zoomForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.scrollView.frame.size.height / scale
        zoomRect.size.width = self.scrollView.frame.size.width  / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        
        return zoomRect
    }
    
    // MARK: - Selecters
    
    @objc func tappedBackBtn() {
        self.dismiss(animated: true, completion: nil)
    }
}
