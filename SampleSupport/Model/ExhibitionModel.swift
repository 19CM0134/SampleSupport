//
//  ExhibitionModel.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import UIKit

// JSONから生成
struct ExhibitionModel: Decodable {
    
    let id: Int
    let name: String
    let topImage: String
    let mapImage: String
    
    private enum Keys: String, CodingKey {
        case id = "exhibitionID"
        case name = "exhibitionName"
        case topImage = "exhibitionTopImage"
        case mapImage = "exhibitionMapImage"
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.topImage = try container.decode(String.self, forKey: .topImage)
        self.mapImage = try container.decode(String.self, forKey: .mapImage)
    }
}
