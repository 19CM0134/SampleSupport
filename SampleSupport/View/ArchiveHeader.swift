//
//  ArchiveHeader.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/20.
//

import UIKit

class ArchiveHeader: UIView {
    
    // MARK: - Properties
    
    private var targetExhibition: [ExhibitionModel] = []
    
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
        setupFileManeger()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        exhibitionTitle.text = targetExhibition[0].exhibitionName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            print(String(data: data, encoding: .utf8)!)
            self.targetExhibition = try JSONDecoder().decode([ExhibitionModel].self, from: data)
            print(self.targetExhibition)
        } catch {
            print(error)
        }
    }
}
