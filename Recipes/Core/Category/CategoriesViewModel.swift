//
//  CategoriesViewModel.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/21/22.
//

import Foundation

protocol CategoriesViewModelInterface {
    var view: CategoriesViewInterface? { get set }
    func viewDidLoad()
    func fetchData()
    func numberOfRowsInSection(at section: Int) -> Int
    func heightForRowAt(at: IndexPath) -> CGFloat
    func didSelectRowAt(at index: Int)
    var dataManagerInterface: DataManagerInterface { get }
}

final class CategoriesViewModel {
    weak var view: CategoriesViewInterface?
    var data: [Drink] = []
    
    let dataManagerInterface: DataManagerInterface
    
    init() {
        dataManagerInterface = DataManager()
    }
}
extension CategoriesViewModel: CategoriesViewModelInterface {
    func viewDidLoad() {
        view?.setUI()
        view?.setLayout()
        view?.setSubviews()
        view?.setTableView()
    }
    func fetchData() {
        dataManagerInterface.parse { [weak self] (response) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.data = response ?? []
                let presentations = self.data.map({ CocktailPresentation(model: $0)})
                self.notify(.showCocktailList(presentations))
                }
                
            }
        }
    
    func notify(_ output: CocktailConstractsOutput) {
        view?.handleViewModelOutput(output)
    }
    func heightForRowAt(at: IndexPath) -> CGFloat {
        .init(60)
    }
    func numberOfRowsInSection(at section: Int) -> Int {
        return data.count
    }
    func didSelectRowAt(at index: Int) {
        print("detail")
    }
}
