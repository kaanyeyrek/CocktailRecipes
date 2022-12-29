//
//  CocktailContracts.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/17/22.
//

import Foundation
// HomeVC Constracts
enum CocktailConstractsOutput: Equatable {
    case showCocktailList([CocktailPresentation])
}
enum CocktailListViewRoute {
    case detail(DetailsViewModelInterface)
}
