//
//  CustomImageView.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/11/22.
//

import UIKit

class CustomImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func config() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        contentMode = .scaleToFill
    }
}
    
