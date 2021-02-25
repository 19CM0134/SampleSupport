//
//  FloorMapViewController.swift
//  SampleTabBar
//
//  Created by cmStudent on 2020/12/11.
//

import UIKit

class FloorMapViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak private var menuBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    private var imageView = UIImageView()
    private var targetExhibition: [ExhibitionModel] = []
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.scrollView.delegate = self
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.bottomAnchor,
                          right: view.rightAnchor,
                          paddingTop: 88,
                          paddingBottom: 83)
        scrollView.backgroundColor = .white
        scrollView.addSubview(imageView)
        self.imageView.backgroundColor = .white
        self.imageView.contentMode = .scaleAspectFit
        setupFileManeger()
        recognitionUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.image = UIImage(named: targetExhibition[0].exhibitionMapImage)
        self.imageView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: scrollView.bounds.width,
                                      height: scrollView.bounds.height)
    }
    
    // MARK: - Helpers
    
    fileprivate func setupFileManeger() {
        guard let url = try? FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: false)
                .appendingPathComponent("exhibition.json") else {return}
        do {
            let data = try Data(contentsOf: url)
            self.targetExhibition = try JSONDecoder().decode([ExhibitionModel].self, from: data)
        } catch {
            print(error)
        }
    }
    
    fileprivate func recognitionUI() {
        menuBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuBtn.tintColor = .black
        menuBtn.addTarget(self, action: #selector(tappedMenuBtn), for: .touchUpInside)
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
    
    @objc func tappedMenuBtn() {
        let vc = MenuViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
