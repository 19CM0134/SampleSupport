//
//  ExhibitionModel.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import UIKit

// JSONから生成
struct ExhibitionModel: Codable {
    
    let exhibitionID: Int
    let exhibitionName: String
    let exhibitionTopImage: String
    let exhibitionMapImage: String
    
    private enum Keys: String, CodingKey {
        case exhibitionID = "exhibitionID"
        case exhibitionName = "exhibitionName"
        case exhibitionTopImage = "exhibitionTopImage"
        case exhibitionMapImage = "exhibitionMapImage"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.exhibitionID = try container.decode(Int.self, forKey: .exhibitionID)
        self.exhibitionName = try container.decode(String.self, forKey: .exhibitionName)
        self.exhibitionTopImage = try container.decode(String.self, forKey: .exhibitionTopImage)
        self.exhibitionMapImage = try container.decode(String.self, forKey: .exhibitionMapImage)
    }
}
