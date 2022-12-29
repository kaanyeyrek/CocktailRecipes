//
//  CategoryCollectionViewCell.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/20/22.
//

import UIKit
import SDWebImage

protocol CategoryViewInterface: AnyObject {
    func setUI()
    func setSubviews()
    func setLayout()
    func configure(with model: CocktailPresentation)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    private let label = TitleLabel()
    private let image = CustomImageView()
    private lazy var viewModel: CategoryCollectionViewModelInterface = CategoryCollectionViewModel()
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
//MARK: - CategoryView Interface
extension CategoryCollectionViewCell: CategoryViewInterface {
    func setUI() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 1, green: 0.8001178503, blue: 0.4396360219, alpha: 1)
    }
    func setSubviews() {
        self.addSubview(label)
        self.addSubview(image)
    }
    func setLayout() {
        image.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        label.anchor(top: self.topAnchor, leading: image.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 75, height: 50))
    }
    func configure(with model: CocktailPresentation) {
        label.text = model.category
        guard let url = URL(string: model.image) else { return }
        image.sd_setImage(with: url)
    }
}
