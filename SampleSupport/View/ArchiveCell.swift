//
//  ArchiveCell.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/19.
//

import UIKit

class ArchiveCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var category = "Category"
    private var name = "Artwork"
    private var time = "01/01 00:00"
    
    public func setText(category: String, name: String, time: String) {
        self.category = category
        self.name = name
        self.time = time
    }
    
    private let categoryName: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    private let artworkName: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        
        return label
    }()
    
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(categoryName)
        categoryName.anchor(top: topAnchor,
                            left: leftAnchor,
                            paddingTop: 10,
                            paddingLeft: 15)
        
        addSubview(artworkName)
        artworkName.anchor(top: categoryName.bottomAnchor,
                           left: categoryName.leftAnchor,
                           paddingTop: 10)
        
        addSubview(timeLabel)
        timeLabel.anchor(top: topAnchor,
                         right: rightAnchor,
                         paddingTop: 10,
                         paddingRight: 15)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryName.text = category
        artworkName.text = name
        timeLabel.text = time
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
