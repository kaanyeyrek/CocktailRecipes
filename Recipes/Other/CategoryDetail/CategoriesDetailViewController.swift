//
//  CategoriesDetailViewController.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/23/22.
//

import UIKit

protocol CategoryDetailViewInterface: AnyObject {
    func setUI()
}

final class CategoriesDetailViewController: UIViewController {
    private lazy var viewModel: CategoriesDetailViewModelInterface = CategoriesDetailViewModel()
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}
extension CategoriesDetailViewController: CategoryDetailViewInterface {
    func setUI() {
        view.backgroundColor = .systemRed
    }
}
