//
//  CategoriesDetailViewModel.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/23/22.
//

import Foundation
protocol CategoriesDetailViewModelInterface {
    var view: CategoryDetailViewInterface? { get set }
    func viewDidLoad()
}

final class CategoriesDetailViewModel {
    weak var view: CategoryDetailViewInterface?
}

extension CategoriesDetailViewModel: CategoriesDetailViewModelInterface {
    func viewDidLoad() {
        view?.setUI()
    }
}
