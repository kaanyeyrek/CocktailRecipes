//
//  CategoryCollectionViewModel.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/20/22.
//

import Foundation

protocol CategoryCollectionViewModelInterface {
    var view: CategoryViewInterface? { get set }
    func override()
}

final class CategoryCollectionViewModel {
    weak var view: CategoryViewInterface?
}
//MARK: - CategoryCollectionViewModel Interface
extension CategoryCollectionViewModel: CategoryCollectionViewModelInterface {
//MARK: - LifeCycle
    func override() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
    }
}
