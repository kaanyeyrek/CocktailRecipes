//
//  CategoriesViewController.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/10/22.
//

import UIKit

protocol CategoriesViewInterface: AnyObject {
    func setUI()
    func setSubviews()
    func setTableView()
    func setLayout()
    func reloadData()
    func handleViewModelOutput(_ output: CocktailConstractsOutput)
}

final class CategoriesViewController: UIViewController {
    private lazy var viewModel: CategoriesViewModelInterface = CategoriesViewModel()
    private let tableView = UITableView()
    private lazy var categories: [CocktailPresentation] = []
    var ordinaryDrink = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        viewModel.fetchData()
    }
}
extension CategoriesViewController: CategoriesViewInterface {
    func setUI() {
        view.backgroundColor = .white
    }
    func setSubviews() {
        view.addSubview(tableView)
    }
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: Constant.categoriesTable)
    }
    func setLayout() {
        tableView.frame = view.bounds
    }
    func reloadData() {
        tableView.reloadData()
    }
    func handleViewModelOutput(_ output: CocktailConstractsOutput) {
        switch output {
        case .showCocktailList(let list):
            self.categories = list
            reloadData()
            print(categories)
        }
    }
}
extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(at: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.categoriesTable, for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
        let model = categories[indexPath.row]
        cell.configure(with: model)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(at: indexPath)
    }
}
