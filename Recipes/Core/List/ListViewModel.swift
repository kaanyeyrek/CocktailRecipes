//
//  ListViewModel.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/25/22.
//

import Foundation
protocol ListViewModelInterface {
    var view: ListViewInterface? { get set }
    func viewWillAppear()
    func viewDidLoad()
    func cellForItem(at indexPath: IndexPath) -> Recipes?
    var numberOfItemsInSection: Int { get }
}

final class ListViewModel {
    weak var view: ListViewInterface?
    private var manager: CoreDataManagerInterface
    private var taskList: [Recipes] = []
    
    init(view: ListViewInterface, manager: CoreDataManagerInterface = CoreDataManager()) {
        self.view = view
        self.manager = manager
    }
}
//MARK: - ListViewModel Interface
extension ListViewModel: ListViewModelInterface {
    //LifeCycle
    func viewWillAppear() {
        taskList = manager.fetchRecipes() ?? []
        view?.reloadData()
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setCollection()
    }
    var numberOfItemsInSection: Int {
        taskList.count
    }
    func cellForItem(at indexPath: IndexPath) -> Recipes? {
        taskList.count > indexPath.row ? taskList[indexPath.row] : nil
    }
}
