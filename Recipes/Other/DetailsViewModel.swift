//
//  DetailsViewModel.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/16/22.
//

import Foundation

protocol DetailsViewModelInterface {
    var view: DetailsViewInterface? { get set }
    func viewDidLoad()
}

final class DetailsViewModel {
    weak var view: DetailsViewInterface?
    private var presentation: CocktailDetailPresentation
    init(model: Drink) {
        self.presentation = CocktailDetailPresentation(model: model)
    }
}
//MARK: - DetailsViewModel Interface
extension DetailsViewModel: DetailsViewModelInterface {
    //MARK: - LifeCycle
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
        view?.showDetail(with: presentation)
        view?.setLayout()
    }
}
