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
   func cocktailCollectionRegister()
   func registerCategoryCell()
}

final class HomeViewController: UIViewController {
    private lazy var data: [CocktailPresentation] = []
    private lazy var viewModel: HomeViewModelInterface? = HomeViewModel()
    fileprivate let questionLabel = CustomLabel()
    fileprivate let searchBar = UISearchBar()
    fileprivate let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    fileprivate var collectionView: UICollectionView?
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
        questionLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 50, height: 100))
        questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300).isActive = true
        searchBar.anchor(top: nil, leading: view.leadingAnchor, bottom: collectionView?.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 15, bottom: 20, right: 15), size: .init(width: 100, height: 50))
        searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -230).isActive = true
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.startAnimating()
    }
    func addSubviews() {
        view.addSubview(questionLabel)
        view.addSubview(searchBar)
        view.addSubview(indicator)
    }
    func setSearchBar() {
        searchBar.placeholder = "Type your best cocktail..."
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
        searchBar.layer.borderColor = UIColor.black.cgColor
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
        collectionView?.reloadData()
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.headerIdentifier)
        collectionView.register(CategoryHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.categoryHeaderIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        collectionView.heightAnchor.constraint(equalToConstant: 650).isActive = true
    }
    func cocktailCollectionRegister() {
        collectionView?.register(CocktailCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constant.identifier)
    }
    func registerCategoryCell() {
        collectionView?.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constant.categoryIdentifier)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel!.numberOfItemsInSections(section: section)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel!.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.item]
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.categoryIdentifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: model)
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.identifier, for: indexPath) as? CocktailCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: (view.frame.width - 20) / 3, height: 70)
        }
        let width: CGFloat = (view.frame.width - 10) / 2
        return .init(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .init(top: 15, left: 15, bottom: 15, right: 15)
        }
        return .init(top: 15, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel?.didSelectItem(at: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.categoryHeaderIdentifier, for: indexPath) as! CategoryHeaderCollectionReusableView
            return header
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.headerIdentifier, for: indexPath) as! HeaderCollectionView
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 180)
    }
}
