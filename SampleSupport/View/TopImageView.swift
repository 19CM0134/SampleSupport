//
//  TopImageView.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/15.
//

import UIKit

class TopImageView: UIView {
    
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
}
