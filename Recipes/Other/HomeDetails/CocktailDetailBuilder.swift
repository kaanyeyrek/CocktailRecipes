//
//  CocktailDetailBuilder.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/18/22.
//

import Foundation

final class CocktailDetailBuilder {
    static func make(with viewModel: DetailsViewModelInterface) -> DetailsViewController {
        let vc = DetailsViewController()
        vc.viewModel = viewModel
        return vc
    }
}
