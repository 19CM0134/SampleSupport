//
//  CategoryModel.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import UIKit

// JSONから生成
struct CategoryModel: Decodable {
    
    let categoryID: Int
    let categoryName: String
    
    private enum Keys: String, CodingKey {
        case categoryID = "categoryID"
        case categoryName = "categoryName"
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.categoryID = try container.decode(Int.self, forKey: .categoryID)
        self.categoryName = try container.decode(String.self, forKey: .categoryName)
    }
}
