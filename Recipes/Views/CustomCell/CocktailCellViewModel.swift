//
//  FoodCellViewModel.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/11/22.
//

import Foundation

protocol CocktailCellViewModelInterface {
    var view: CocktailCollectionViewCellInterface? { get set }
    func override()
}

final class CocktailCellViewModel {
    weak var view: CocktailCollectionViewCellInterface?
}
//MARK: - FoodCellViewModelInterface Delegate
extension CocktailCellViewModel: CocktailCellViewModelInterface {
//LifeCycle
    func override() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
    }
}
