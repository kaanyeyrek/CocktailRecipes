//
//  CustomButton.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/18/22.
//

import UIKit

class CustomButton: UIButton {

    init() {
        super.init(frame: .zero)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func config() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        contentMode = .scaleToFill
        backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        setTitle("Ingredient:", for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        titleLabel?.textAlignment = .center
    }
}
