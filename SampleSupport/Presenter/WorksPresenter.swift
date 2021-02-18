//
//  WorksPresenter.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import Foundation

protocol WorksPresenterDelegate: NSObjectProtocol {
    func setWorksToScreen(_ works: [WorksModel])
}

final class WorksPresenter {
    
    weak var delegate: WorksPresenterDelegate?
    private let worksModels: [WorksModel]
    
    // MARK: - Init
    
    init() {
        if let path = Bundle.main.path(forResource: "WorksData", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.worksModels = try! JSONDecoder().decode([WorksModel].self, from: data)
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }
    
    // MARK: - Function
    
    func getWorksList() {
        self.delegate?.setWorksToScreen(worksModels)
    }
}
