//
//  WorksModel.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import UIKit

// JSONから生成
struct WorksModel: Codable {
    
    let worksID: Int
    let categoryID: Int
    let worksName: String
    let imageName: String
    let exhibitionID: Int
    let tagsID: String
    
    private enum Keys: String, CodingKey {
        case worksID = "worksID"
        case categoryID = "categoryID"
        case worksName = "worksName"
        case imageName = "imageName"
        case exhibitionID = "exhibitionID"
        case tagsID = "tagsID"
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.worksID = try container.decode(Int.self, forKey: .worksID)
        self.categoryID = try container.decode(Int.self, forKey: .categoryID)
        self.worksName = try container.decode(String.self, forKey: .worksName)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.exhibitionID = try container.decode(Int.self, forKey: .exhibitionID)
        self.tagsID = try container.decode(String.self, forKey: .tagsID)
    }
}
