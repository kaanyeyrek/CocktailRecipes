//
//  CustomTextField.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/24/22.
//

import UIKit

class CustomTextField: UITextField {
    private let padding: CGFloat
    private let gradientLayer = CAGradientLayer()
    private let maskLayer = CAShapeLayer()
    private let maskPath = CGMutablePath()
    
    init(placeHolder: String, padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        self.placeholder = placeHolder
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 15)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 15)
    }
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 30)
    }
    fileprivate func config() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        leftViewMode = .always
        backgroundColor = .white
        autocorrectionType = .no
        autocapitalizationType = .none
        returnKeyType = .done
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        contentVerticalAlignment = .top
    }
  }
