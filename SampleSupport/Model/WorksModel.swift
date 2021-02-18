//
//  WorksModel.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import UIKit

// JSONから生成
struct WorksModel: Decodable {
    
    let id: Int
    let categoryID: Int
    let name: String
    let imageName: String
    let exhibitionID: Int
    
    private enum Keys: String, CodingKey {
        case id = "worksID"
        case categoryID = "categoryID"
        case name = "worksName"
        case imageName = "imageName"
        case exhibitionID = "exhibitionID"
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.categoryID = try container.decode(Int.self, forKey: .categoryID)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.exhibitionID = try container.decode(Int.self, forKey: .exhibitionID)
    }
}

