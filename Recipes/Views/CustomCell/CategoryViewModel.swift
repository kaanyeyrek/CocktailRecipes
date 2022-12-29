//
//  CategoriesViewModel.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/22/22.
//

import Foundation

protocol CategoryTableModelInterface {
    var view: CategoriesTableViewInterface? { get set }
    func override()
}

final class CategoryViewModel {
    weak var view: CategoriesTableViewInterface?
}
//MARK: - CategoryTableViewModel Interface
extension CategoryViewModel: CategoryTableModelInterface {
//MARK: - LifeCycle
    func override() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
    }
}
