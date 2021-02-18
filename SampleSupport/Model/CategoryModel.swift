//
//  CategoryModel.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import UIKit

// JSONから生成
struct CategoryModel: Decodable {
    
    let id: Int
    let name: String
    
    private enum Keys: String, CodingKey {
        case id = "categoryID"
        case name = "categoryName"
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
