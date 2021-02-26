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
    private var imageView     = UIImageView()
    private var catPresenter  : CategoryPresenter!
    private var targetCategory: [CategoryModel] = []
    private var worksPresenter: WorksPresenter!
    private var targetWorks   : [WorksModel] = []
    private var id            : String = ""
    
    public func setter(id: String) {
        self.id = id
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
        scrollView.addSubview(imageView)
        self.imageView.backgroundColor = .white
        self.imageView.contentMode = .scaleAspectFit
        
        setupCategoryPresenter()
        setupWorksPresenter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for n in 0..<targetWorks.count {
            if targetWorks[n].tagsID == id {
                let catID = targetWorks[n].categoryID - 1
                setNavBar(category: targetCategory[catID].categoryName,
                          title: targetWorks[n].worksName)
                imageView.image = UIImage(named: targetWorks[n].imageName)
            }
        }
        self.imageView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: scrollView.frame.width,
                                      height: scrollView.frame.height)
    }
    
    // MARK: - Helpers
    
    fileprivate func setupCategoryPresenter() {
        catPresenter = CategoryPresenter()
        catPresenter.delegate = self
        catPresenter.getCategoryList()
    }
    
    fileprivate func setupWorksPresenter() {
        worksPresenter = WorksPresenter()
        worksPresenter.delegate = self
        worksPresenter.getWorksList()
    }
    
    fileprivate func setNavBar(category: String, title: String) {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                   width: WIDTH - 110,
                                                   height: 50))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "\(category)\n\(title)"
        self.navigationItem.titleView = label
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_back_ios"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(tappedBackBtn))
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {}
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {}
    
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

// MARK: - CategoryPresenterDelegate

extension DetailedWorksViewController: CategoryPresenterDelegate {
    func setCategoryToScreen(_ category: [CategoryModel]) {
        targetCategory = category
    }
}

// MARK: - WorksPresenterDelegate

extension DetailedWorksViewController: WorksPresenterDelegate {
    func setWorksToScreen(_ works: [WorksModel]) {
        targetWorks = works
    }
}
