//
//  ExhibiPresenter.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/24.
//

import Foundation

protocol ExhibiPresenterDelegate: NSObjectProtocol {
    func setExhibiToScreen(_ exhibition: [ExhibitionModel])
}

final class ExhibiPresenter {
    
    weak var delegate: ExhibiPresenterDelegate?
    private let exhibiModels: [ExhibitionModel]
    
    // MARK: - Init
    
    init() {
        if let path = Bundle.main.path(forResource: "exhibition", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.exhibiModels = try! JSONDecoder().decode([ExhibitionModel].self, from: data)
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }
    
    // MARK: - Function
    
    func getExhibiInfo() {
        self.delegate?.setExhibiToScreen(exhibiModels)
    }
}
