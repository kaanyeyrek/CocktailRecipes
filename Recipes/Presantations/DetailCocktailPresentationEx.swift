//
//  DetailCocktailPresentationEx.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/18/22.
//

import Foundation

extension CocktailDetailPresentation {
    init(model: Drink) {
        self.init(title: model.strDrink, image: model.strDrinkThumb, info: model.strInstructions, material1: model.strIngredient1, material2: model.strIngredient2, material3: model.strIngredient3 ?? "")
    }
}
