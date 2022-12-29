//
//  MyListCollectionViewModel.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/25/22.
//

import Foundation
protocol MyListCollectionViewModelInterface {
    var view: MyListCollectionViewInterface? { get set }
    func override()
}

final class MyListCollectionViewModel {
    weak var view: MyListCollectionViewInterface?
}
//MARK: - MyListCollectionViewModel Interface
extension MyListCollectionViewModel: MyListCollectionViewModelInterface {
    func override() {
        view?.setAddSubviews()
        view?.setLayout()
        view?.setLabelFeature()
        view?.setUI()
    }
}
