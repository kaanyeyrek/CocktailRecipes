//
//  CustomButton.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/18/22.
//

import UIKit

class CustomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        config()
        setTitle(title, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func config() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        contentMode = .scaleToFill
        backgroundColor = .black
        titleLabel?.font = UIFont(name: "Rubik-Medium", size: 18)
        titleLabel?.textAlignment = .center
    }
}
