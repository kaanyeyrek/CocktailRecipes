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
    var dataManagerInterface: DataManagerInterface { get }
    func fetchData()
    func changeLoading()
    func didSelectItem(at index: Int)
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
        view?.cocktailCollectionRegister()
        view?.registerCategoryCell()
        view?.tapGesture()
        view?.setSearchBar()
}
    func handleBackButton() {
        view?.resignFirstResponder()
    }
    func fetchData() {
        changeLoading()
        dataManagerInterface.parse { [weak self] (response) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.changeLoading()
                self.data = response ?? []
                let presentations = self.data.map({ CocktailPresentation(model: $0) })
                self.notify(.showCocktailList(presentations))
            }
        }
    }
    func changeLoading() {
        isloading = !isloading
        view?.changeLoading(isLoad: isloading)
    }
    var numberOfSections: Int { 2 }
    func numberOfItemsInSections(section: Int) -> Int { data.count }
    func didSelectItem(at index: Int) {
       let models = data[index]
       let viewModel = DetailsViewModel(model: models)
        view?.navigate(to: .detail(viewModel))
    }
    //Helper
    func notify(_ output: CocktailConstractsOutput) {
        view?.handleViewModelOutput(output)
    }
 }

