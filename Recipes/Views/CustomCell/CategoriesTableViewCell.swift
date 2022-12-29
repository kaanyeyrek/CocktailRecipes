//
//  CategoriesTableViewCell.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/22/22.
//

import UIKit

protocol CategoriesTableViewInterface: AnyObject {
    func setUI()
    func setSubviews()
    func setLayout()
    func configure(with model: CocktailPresentation)
}

class CategoriesTableViewCell: UITableViewCell {
    private var label = TitleLabel()
    private lazy var viewModel: CategoryTableModelInterface = CategoryViewModel()
//MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel.view = self
        viewModel.override()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - CategoryTableView Interface
extension CategoriesTableViewCell: CategoriesTableViewInterface {
    func setUI() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        label.textAlignment = .left
    }
    func setSubviews() {
        self.addSubview(label)
    }
    func setLayout() {
        label.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 18, bottom: 5, right: 0))
    }
    func configure(with model: CocktailPresentation) {
        label.text = model.category
    }
}
