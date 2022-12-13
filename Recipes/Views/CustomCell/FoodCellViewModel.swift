//
//  FoodCellViewModel.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/11/22.
//

import Foundation

protocol FoodCellViewModelInterface {
    var view: FoodCollectionViewCellInterface? { get set }
    func override()
}
final class FoodCellViewModel {
    weak var view: FoodCollectionViewCellInterface?
}
//MARK: - FoodCellViewModelInterface Delegate
extension FoodCellViewModel: FoodCellViewModelInterface {
//LifeCycle
    func override() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
    }
}
