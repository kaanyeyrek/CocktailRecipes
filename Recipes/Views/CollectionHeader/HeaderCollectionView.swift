//
//  HeaderCollectionReusableView.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/19/22.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    fileprivate let effect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    fileprivate let image = CustomImageView()
    fileprivate let label = TitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configure()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviews() {
        addSubview(effect)
        addSubview(image)
        addSubview(label)
    }
    func layout() {
        effect.frame = bounds
        image.frame = bounds
        label.frame = bounds
        sendSubviewToBack(image)
    }
    func configure() {
        image.image = #imageLiteral(resourceName: "banner")
        label.textColor = .white
        label.text = "Popular Cocktails"
        label.font = UIFont(name: "Copperplate", size: 23)
    }
}
