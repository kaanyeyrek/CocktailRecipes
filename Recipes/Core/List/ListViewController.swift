//
//  FavoritesViewController.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/10/22.
//

import UIKit
import CoreData

protocol ListViewInterface: AnyObject {
    func setUI()
    func setCollection()
    func reloadData()
}

final class ListViewController: UIViewController {
    private lazy var viewModel: ListViewModelInterface = ListViewModel(view: self)
    private var collectionView: UICollectionView?
    private var randomColor = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9450086951, green: 0.4330791235, blue: 0.4120393991, alpha: 1), #colorLiteral(red: 0.174071312, green: 0.4268400073, blue: 0.8156251311, alpha: 1)]
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
//MARK: - ListViewInterface delegate
extension ListViewController: ListViewInterface {
    func setUI() {
        view.backgroundColor = .white
    }
    func setCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(MyListCollectionViewCell.self, forCellWithReuseIdentifier: Constant.myListCollection)
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 0), size: .init(width: view.frame.width, height: view.frame.height))
    }
    func reloadData() {
        collectionView?.reloadData()
    }
}
//MARK: - UICollectionView DataSource and DelegateFlowLayout methods
extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.myListCollection, for: indexPath) as? MyListCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = randomColor.randomElement()
        guard let taskList = viewModel.cellForItem(at: indexPath) else { return cell }
        cell.setTitle(entity: taskList)
        cell.setIngredients(entity: taskList)
        cell.setDescriptions(entity: taskList)
        cell.setImage(entity: taskList)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 10) / 2
        return .init(width: width, height: width * 2)
    }
}
//MARK: - UICollection Delegate Methods
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
