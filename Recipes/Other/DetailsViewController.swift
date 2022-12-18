//
//  DetailsViewController.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/16/22.
//

import UIKit
import SDWebImage

protocol DetailsViewInterface: AnyObject {
    func showDetail(with presentation: CocktailDetailPresentation)
    func setLayout()
    func setSubviews()
    func setUI()
}

final class DetailsViewController: UIViewController {
    fileprivate let image = CustomImageView()
    fileprivate let label = TitleLabel()
    fileprivate let info = TitleLabel()
    fileprivate let headerButton = CustomButton()
    fileprivate let materialLabel = TitleLabel()
    fileprivate let materialLabel2 = TitleLabel()
    fileprivate let materialLabel3 = TitleLabel()
    fileprivate let materialLabel4 = TitleLabel()
    var viewModel: DetailsViewModelInterface!
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.view = self
        viewModel?.viewDidLoad()
    }
}
//MARK: - DetailsViewController Delegate
extension DetailsViewController: DetailsViewInterface {
    func showDetail(with presentation: CocktailDetailPresentation) {
        label.text = presentation.title
        guard let url = URL(string: presentation.image) else { return }
        image.sd_setImage(with: url)
        info.text = presentation.info
        materialLabel.text = (" \(presentation.material1)")
        materialLabel2.text = (" \(presentation.material2)")
        materialLabel3.text = (" \(presentation.material3)")
    }
    func setUI() {
        view.backgroundColor = .white
        image.layer.cornerRadius = 0
        label.font = .boldSystemFont(ofSize: 20)
        materialLabel.textAlignment = .left
        materialLabel2.textAlignment = .left
        materialLabel3.textAlignment = .left
    }
    func setSubviews() {
        view.addSubview(label)
        view.addSubview(image)
        view.addSubview(info)
        view.addSubview(materialLabel)
        view.addSubview(headerButton)
        view.addSubview(materialLabel2)
        view.addSubview(materialLabel3)
    }
    func setLayout() {
        image.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 400))
        label.anchor(top: image.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .init(width: 50, height: 150))
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        info.anchor(top: label.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10) , size: .init(width: 100, height: 80))
        info.sizeToFit()
        info.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        headerButton.anchor(top: info.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 0), size: .init(width: 120, height: 40))
        headerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 85).isActive = true
        
        materialLabel.anchor(top: headerButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 50))
        materialLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 140).isActive = true
        
        materialLabel2.anchor(top: headerButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 50))
        materialLabel2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160).isActive = true
        
        materialLabel3.anchor(top: headerButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 50))
        materialLabel3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 180).isActive = true
    }
}
