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
    var data: [Drink] { get set }
    var dataManagerInterface: DataManagerInterface { get }
    func fetchData()
    func changeLoading()
}
final class HomeViewModel {
    weak var view: HomeViewInterface?
    let dataManagerInterface: DataManagerInterface
    var data: [Drink] = []
    private var isloading = false
    
    init() {
        dataManagerInterface = DataManager()
    }
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
    func fetchData() {
        changeLoading()
        dataManagerInterface.parse { [weak self] (response) in
            DispatchQueue.main.async {
                self?.changeLoading()
                self?.data = response ?? []
                self?.view?.saveDatas(values: self?.data ?? [])
            }
        }
    }
    func changeLoading() {
        isloading = !isloading
        view?.changeLoading(isLoad: isloading)
    }
    func numberOfItemsInSections(section: Int) -> Int {
       return data.count
    }
    var numberOfSections: Int {
        8
    }
 }

