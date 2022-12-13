//
//  FoodCollectionViewCell.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/11/22.
//

import UIKit
protocol FoodCollectionViewCellInterface: AnyObject {
    func setUI()
    func setSubviews()
    func setLayout()
    func configure()
}
class FoodCollectionViewCell: UICollectionViewCell {
    fileprivate let view = UIView()
    fileprivate let label = TitleLabel()
    fileprivate let secondLabel = TitleLabel()
    fileprivate let image = CustomImageView()
    private lazy var viewModel: FoodCellViewModelInterface =
    FoodCellViewModel()
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
//MARK: - FoodCollectionViewCellInterface Delegate
extension FoodCollectionViewCell: FoodCollectionViewCellInterface {
    func setUI() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
    }
    func setSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(secondLabel)
        contentView.addSubview(image)
        contentView.addSubview(view)
    }
    func setLayout() {
        view.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 150, height: 200))
        contentView.sendSubviewToBack(view)
        image.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 150))
        label.anchor(top: view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 30, bottom: 5, right: 5), size: .init(width: 50, height: 40))
        secondLabel.anchor(top: view.bottomAnchor, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 20), size: .init(width: 80, height: 40))
    }
    public func configure() {
        image.image = #imageLiteral(resourceName: "banner")
        label.text = "Mozzarella Food\n243Kcal"
        secondLabel.text = " ⏱️ 35 min "
    }
}
