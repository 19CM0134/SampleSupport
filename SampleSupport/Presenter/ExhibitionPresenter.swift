//
//  ExhibitionPresenter.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import Foundation

protocol ExhibitionPresenterDelegate: NSObjectProtocol {
    func setExhibitionToScreen(_ exhibition: [ExhibitionModel])
}

final class ExhibitionPresenter {
    
    weak var delegate: ExhibitionPresenterDelegate?
    private let exhibitionModels: [ExhibitionModel]
    
    // MARK: - Init
    
    init() {
        if let path = Bundle.main.path(forResource: "ExhibitionData", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.exhibitionModels = try! JSONDecoder().decode([ExhibitionModel].self, from: data)
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }
    
    // MARK: - Function
    
    func getExhibitionInfo() {
        self.delegate?.setExhibitionToScreen(exhibitionModels)
    }
}
