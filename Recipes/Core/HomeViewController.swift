//
//  ViewController.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/10/22.
//

import UIKit

protocol HomeViewInterface: AnyObject {
   func setLayout()
   func addSubviews()
   func setSearchBar()
   func configCollectionView()
   func tapGesture()
   func collectionReload()
   func resignFirstResponder()
   func changeLoading(isLoad: Bool)
   func handleViewModelOutput(_ output: CocktailConstractsOutput)
   func navigate(to Route: CocktailListViewRoute)
   static func createLayout() -> UICollectionViewCompositionalLayout
}

final class HomeViewController: UIViewController {
    private enum Constant {
        static let identifier = "FoodCollectionViewCell"
    }
    private lazy var data: [CocktailPresentation] = []
    private lazy var viewModel: HomeViewModelInterface? = HomeViewModel()
    fileprivate let questionLabel = CustomLabel()
    fileprivate let searchBar = UISearchBar()
    fileprivate let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeViewController.createLayout())
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.view = self
        viewModel?.viewDidLoad()
        viewModel?.fetchData()
        view.backgroundColor = .white
    }
}
//MARK: - HomeViewInterface Delegate
extension HomeViewController: HomeViewInterface {
    func setLayout() {
        questionLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 0), size: .init(width: 50, height: 100))
        questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300).isActive = true
        searchBar.anchor(top: nil, leading: view.leadingAnchor, bottom: collectionView.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 25, bottom: 20, right: 25), size: .init(width: 100, height: 50))
        searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -230).isActive = true
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.startAnimating()
    }
    func addSubviews() {
        view.addSubview(questionLabel)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(indicator)
    }
    func setSearchBar() {
        searchBar.placeholder = "Type your ingredients"
        searchBar.searchTextField.leftViewMode = .always
        searchBar.searchTextField.returnKeyType = .done
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.barTintColor = .white
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.systemMint.cgColor
    }
    func tapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleBackButton))
        gesture.cancelsTouchesInView = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }
    func resignFirstResponder() {
        searchBar.resignFirstResponder()
    }
    func collectionReload() {
        collectionView.reloadData()
    }
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    func handleViewModelOutput(_ output: CocktailConstractsOutput) {
        switch output {
        case .showCocktailList(let cocktail):
            self.data = cocktail
            collectionReload()
        }
    }
    func navigate(to Route: CocktailListViewRoute) {
        switch Route {
        case .detail(let viewModel):
            let vc = CocktailDetailBuilder.make(with: viewModel)
            navigationController?.pushViewController(vc, animated: false)
        }
    }
//MARK: - Action buttons
    @objc fileprivate func handleBackButton(with gesture: UITapGestureRecognizer) {
        viewModel?.handleBackButton()
    }
}
//MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: Constant.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    static func createLayout() -> UICollectionViewCompositionalLayout { 
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 5
        item.contentInsets.bottom = 5
       // Second item
        let verticalItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
        verticalItem.contentInsets.trailing = 5
        verticalItem.contentInsets.bottom = 5
        // Group
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), repeatingSubitem: verticalItem, count: 2)
        let doubleStackGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(200)), subitems: [item,verticalGroup])
        // Sections
        let section = NSCollectionLayoutSection(group: doubleStackGroup)
        section.orthogonalScrollingBehavior = .continuous
        // Return
        return UICollectionViewCompositionalLayout(section: section)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel!.numberOfItemsInSections(section: section)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel!.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.identifier, for: indexPath) as? FoodCollectionViewCell else { return UICollectionViewCell() }
        let model = data[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel?.didSelectItem(at: indexPath.item)
    }
}

