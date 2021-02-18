//
//  CategoryPresenter.swift
//  SampleSupport
//
//  Created by cmStudent on 2021/02/18.
//

import Foundation

protocol CategoryPresenterDelegate: NSObjectProtocol {
    func setCategoryToScreen(_ category: [CategoryModel])
}

final class CategoryPresenter {
    
    weak var delegate: CategoryPresenterDelegate?
    private let categoryModels: [CategoryModel]
    
    // MARK: - Init
    
    init() {
        if let path = Bundle.main.path(forResource: "CategoryData", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            self.categoryModels = try! JSONDecoder().decode([CategoryModel].self, from: data)
        } else {
            fatalError("Invalid json format or existence of file.")
        }
    }
    
    // MARK: - Function
    
    func getCategoryList() {
        self.delegate?.setCategoryToScreen(categoryModels)
    }
}
