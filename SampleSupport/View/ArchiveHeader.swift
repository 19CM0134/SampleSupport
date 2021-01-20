//
//  ArchiveHeader.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/20.
//

import UIKit

class ArchiveHeader: UIView {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        label.text = "履歴"
        
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(left: leftAnchor,
                          bottom: bottomAnchor,
                          paddingLeft: 15,
                          paddingBottom: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
