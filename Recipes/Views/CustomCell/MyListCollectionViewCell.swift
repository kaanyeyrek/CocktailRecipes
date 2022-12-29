//
//  MyListCollectionViewCell.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/25/22.
//

import UIKit

protocol MyListCollectionViewInterface: AnyObject {
    func setTitle(entity: Recipes)
    func setIngredients(entity: Recipes)
    func setDescriptions(entity: Recipes)
    func setImage(entity: Recipes)
    func setUI()
    func setAddSubviews()
    func setLayout()
    func setLabelFeature()
}

final class MyListCollectionViewCell: UICollectionViewCell {
    private lazy var viewModel: MyListCollectionViewModelInterface = MyListCollectionViewModel()
    private let label = CustomLabel()
    private let label2 = CustomLabel()
    private let label3 = CustomLabel()
    private let image = CustomImageView()
//MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.view = self
        viewModel.override()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - MyListView Interface
extension MyListCollectionViewCell: MyListCollectionViewInterface {
    func setUI() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        image.layer.cornerRadius = 0
    }
    func setLabelFeature() {
        label.textAlignment = .center
        label2.numberOfLines = 5
        label3.numberOfLines = 10
        label.textColor = .white
        label2.textColor = .white
        label3.textColor = .white
        label.font = UIFont(name: "Rubik-Medium", size: 20)
        label2.font = UIFont(name: "Rubik-Medium", size: 20)
        label3.font = UIFont(name: "Rubik-Medium", size: 20)
        
    }
    func setLayout() {
        label.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 5, bottom: 0, right: 5))
        label2.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        label2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -130).isActive = true
        label3.anchor(top: self.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        label3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        image.anchor(top: label3.bottomAnchor, leading: self.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        self.bringSubviewToFront(image)
        image.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 150).isActive = true
    }
    func setAddSubviews() {
        self.addSubview(label)
        self.addSubview(label2)
        self.addSubview(label3)
        self.addSubview(image)
    }
    func setTitle(entity: Recipes) {
        label.text = entity.title
    }
    func setIngredients(entity: Recipes) {
        label2.text = "Ingredients: \n\(entity.ingredients ?? "")"
    }
    func setDescriptions(entity: Recipes) {
        label3.text = "Descriptions: \n\(entity.descriptions ?? "")"
    }
    func setImage(entity: Recipes) {
        guard let img = entity.savedImage else { return }
        image.image = UIImage(data: img)
    }
}
