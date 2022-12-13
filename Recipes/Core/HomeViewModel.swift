//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/10/22.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    var numberOfSections: Int { get }
    func numberOfItemsInSections(section: Int) -> Int
    func viewDidLoad()
    func viewWillAppear()
    func handleBackButton()
}
final class HomeViewModel {
    weak var view: HomeViewInterface?
}
//MARK: - HomeViewModelInterface Delegate
extension HomeViewModel: HomeViewModelInterface {
    // LifeCycle
    func viewWillAppear() {
    }
    func viewDidLoad() {
        view?.addSubviews()
        view?.setLayout()
        view?.configCollectionView()
        view?.tapGesture()
        view?.setSearchBar()
}
    func handleBackButton() {
        view?.resignFirstResponder()
    }
    func numberOfItemsInSections(section: Int) -> Int {
        if section == 0 {
            return 12
        }
        return 10
    }
    var numberOfSections: Int {
        12
    }
 }

