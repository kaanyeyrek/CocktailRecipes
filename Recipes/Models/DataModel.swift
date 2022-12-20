//
//  DataModel.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/11/22.
//

import Foundation
//MARK: - Codable Model
struct Cocktail: Codable {
    let drinks: [Drink]
}
struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
    let strInstructions: String
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String?
    let strCategory: String
}
