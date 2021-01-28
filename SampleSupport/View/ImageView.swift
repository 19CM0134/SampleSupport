//
//  ImageView.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/13.
//

import UIKit

class ImageView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    let imageView: UIImageView
    
    // MARK: - Init
    
    init(frame: CGRect, imageName: String) {
        
        self.imageView = UIImageView()
        // 余白
        self.imageView.backgroundColor = .white
        
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(imageView)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = UIImage(named: imageName)
        self.imageView.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(sender:)))
        pinchGesture.delegate = self
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.anchor(top: self.topAnchor,
                              left: self.leftAnchor,
                              bottom: self.bottomAnchor,
                              right: self.rightAnchor)
    }
    
    var currentScale: CGFloat = 1.0
    
    @objc func pinchAction(sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            // senderのscaleは、指を動かしていない状態が1.0となる
            // 現在の拡大率に、(scaleから1を引いたもの) / 10(補正率)を加算する
            currentScale = currentScale + (sender.scale - 1) / 10
            // 拡大率が基準から外れる場合は、補正する
            if currentScale < 0.8 {
                currentScale = 1.0
            } else if currentScale > 2.5 {
                currentScale = 2.5
            }
            // 計算後の拡大率で、imageViewを拡大縮小する
            imageView.transform = CGAffineTransform(scaleX: currentScale,
                                                    y: currentScale)
            
        default:
            // ピンチ中と同様だが、拡大率に範囲が異なる
            if currentScale < 0.8 {
                currentScale = 1.0
            } else if currentScale > 2.0 {
                currentScale = 2.0
            }
            
            // 拡大率が基準から外れている場合、指を話した時にアニメーションで拡大率を補正する
            UIView.animate(withDuration: 0.2, animations: {
                self.imageView.transform = CGAffineTransform(scaleX: self.currentScale,
                                                             y: self.currentScale)
            }, completion: nil)
        }
    }
}
