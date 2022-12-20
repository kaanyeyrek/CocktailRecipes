//
//  CocktailPresentation.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/17/22.
//

import UIKit

final class CocktailPresentation: NSObject {
    let title: String
    let image: String
    let category: String
    
    init(title: String, image: String, category: String) {
        self.title = title
        self.image = image
        self.category = category
        super.init()
    }
    override func isEqual(_ object: Any?) -> Bool {
        guard let model = object as? CocktailPresentation else { return false }
        return self.title == model.title && self.image == model.image && self.category == model.category
    }
}
