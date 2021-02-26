//
//  ArchiveCell.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/19.
//

import UIKit

class ArchiveCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var id: String!
    private var catPresenter  : CategoryPresenter!
    private var targetCategory: [CategoryModel] = []
    private var worksPresenter: WorksPresenter!
    private var targetWorks   : [WorksModel] = []
    private var getArchive    : [String : String] = [:]
    
    public func setId(id: String) {
        self.id = id
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
        getArchive = UserDefaults.standard.dictionary(forKey: "archive")! as! [String : String]
        setupCategoryPresenter()
        setupWorksPresenter()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for n in 0..<targetWorks.count {
            if targetWorks[n].tagsID == id {
                let catID = targetWorks[n].categoryID - 1
                categoryName.text = targetCategory[catID].categoryName
                artworkName.text = targetWorks[n].worksName
            }
        }
        timeLabel.text = getArchive[id]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}

// MARK: - CategoryPresenterDelegate

extension ArchiveCell: CategoryPresenterDelegate {
    func setCategoryToScreen(_ category: [CategoryModel]) {
        targetCategory = category
    }
}

// MARK: - WorksPresenterDelegate

extension ArchiveCell: WorksPresenterDelegate {
    func setWorksToScreen(_ works: [WorksModel]) {
        targetWorks = works
    }
}
