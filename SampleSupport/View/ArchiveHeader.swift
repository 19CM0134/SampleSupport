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
    
    private let exhibitionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17.5)
        label.textColor = .black
        label.text = "電子学園 創立70周年記念 『感謝。そして挑戦』"
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          paddingTop: 20,
                          paddingLeft: 15)
        
        addSubview(exhibitionTitle)
        exhibitionTitle.anchor(top: titleLabel.bottomAnchor,
                             left: leftAnchor,
                             paddingTop: 10,
                             paddingLeft: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
