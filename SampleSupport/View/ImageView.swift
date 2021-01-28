//
//  ImageView.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/13.
//

import UIKit

class ImageView: UIView {
    
    // MARK: - Properties
    
    let scrollView: UIScrollView
    let imageView: UIImageView
    
    // MARK: - Init
    
    init(frame: CGRect, imageName: String) {
        self.scrollView = UIScrollView()
        self.scrollView.maximumZoomScale = 5.0
        self.scrollView.minimumZoomScale = 0.5
        
        self.imageView = UIImageView()
        // 余白
        self.imageView.backgroundColor = .white
        
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(scrollView)
        self.scrollView.delegate = self
        
        self.scrollView.addSubview(imageView)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = UIImage(named: imageName)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollView.anchor(top: self.topAnchor,
                               left: self.leftAnchor,
                               bottom: self.bottomAnchor,
                               right: self.rightAnchor,
                               paddingTop: 88,
                               paddingBottom: 80)
        
        self.imageView.anchor(top: self.scrollView.topAnchor,
                              left: self.scrollView.leftAnchor,
                              bottom: self.scrollView.bottomAnchor,
                              right: self.scrollView.rightAnchor)

    }
}

// MARK: - UIScrollViewDelegate

extension ImageView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // ズーム終了時の処理
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        //ズーム開始時の処理
    }
    
    func zoomForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.scrollView.frame.size.height / scale
        zoomRect.size.width = self.scrollView.frame.size.width / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        
        return zoomRect
    }
}
