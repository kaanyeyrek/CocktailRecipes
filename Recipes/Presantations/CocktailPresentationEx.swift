//
//  CocktailPresentationEx.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/17/22.
//

import Foundation

extension CocktailPresentation {
    
    convenience init(model: Drink) {
        self.init(title: model.strDrink, image: model.strDrinkThumb)
    }
}
