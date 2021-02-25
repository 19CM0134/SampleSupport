//
//  ArchiveCell.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/19.
//

import UIKit

class ArchiveCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var id: Int!
//    private var catPresenter  : CategoryPresenter!
    private var targetCategory: [CategoryModel] = []
//    private var worksPresenter: WorksPresenter!
    private var targetWorks   : [WorksModel] = []
    private var getArchive    : [String : String] = [:]
    
    public func setId(id: Int) {
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
//        setupCategoryPresenter()
//        setupWorksPresenter()
        setupFileManeger()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let workID: Int = id - 1
        let catID = targetWorks[workID].categoryID - 1
        let idStr = String(id)
        categoryName.text = targetCategory[catID].categoryName
        artworkName.text = targetWorks[workID].worksName
        timeLabel.text = getArchive[idStr]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
//    fileprivate func setupCategoryPresenter() {
//        catPresenter = CategoryPresenter()
//        catPresenter.delegate = self
//        catPresenter.getCategoryList()
//    }
    
//    fileprivate func setupWorksPresenter() {
//        worksPresenter = WorksPresenter()
//        worksPresenter.delegate = self
//        worksPresenter.getWorksList()
//    }
    
    fileprivate func setupFileManeger() {
        guard let url = try? FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: false)
                .appendingPathComponent("category.json") else {return}
        do {
            let data = try Data(contentsOf: url)
            self.targetCategory = try JSONDecoder().decode([CategoryModel].self, from: data)
        } catch {
            print(error)
        }
        
        guard let worksURL = try? FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: false)
                .appendingPathComponent("works.json") else {return}
        do {
            let data = try Data(contentsOf: worksURL)
            self.targetWorks = try JSONDecoder().decode([WorksModel].self, from: data)
        } catch {
            print(error)
        }
    }
}

// MARK: - CategoryPresenterDelegate

//extension ArchiveCell: CategoryPresenterDelegate {
//    func setCategoryToScreen(_ category: [CategoryModel]) {
//        targetCategory = category
//    }
//}

// MARK: - WorksPresenterDelegate

//extension ArchiveCell: WorksPresenterDelegate {
//    func setWorksToScreen(_ works: [WorksModel]) {
//        targetWorks = works
//    }
//}
