//
//  CustomLabel.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/10/22.
//

import UIKit

class CustomLabel: UILabel {
    init() {
        super.init(frame: .zero)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func config() {
        text = "What is in your Kitchen?"
        font = UIFont(name: "HelveticaNeue-Medium", size: 25)
        layer.cornerRadius = 8
        clipsToBounds = true
        textColor = .black
    }
}
class TitleLabel: UILabel {
    init() {
        super.init(frame: .zero)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func config() {
        textColor = .black
        layer.cornerRadius = 8
        clipsToBounds = true
        numberOfLines = 0
        font = UIFont(name: "HelveticaNeue-Medium", size: 15)
    }
}
