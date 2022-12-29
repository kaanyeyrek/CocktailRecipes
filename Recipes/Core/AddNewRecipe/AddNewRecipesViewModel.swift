//
//  AddNewRecipesViewModel.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/24/22.
//

import Foundation

protocol AddNewRecipesViewModelInterface {
    var view: AddNewRecipeViewInterface? { get set }
    func viewDidLoad()
    func didTapAddButton()
    func didTapSelectImageButton()
}

final class AddNewRecipesViewModel {
    weak var view: AddNewRecipeViewInterface?
    private let dataManager: CoreDataManagerInterface
    
    init(view: AddNewRecipeViewInterface, dataManager: CoreDataManagerInterface = CoreDataManager()) {
        self.view = view
        self.dataManager = dataManager
    }
}
extension AddNewRecipesViewModel: AddNewRecipesViewModelInterface {
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
        view?.setActions()
    }
    func didTapAddButton() {
        if let title = view?.titleText, !title.isEmpty, title.count < 15,
           let ingredients = view?.ingredientsText, !ingredients.isEmpty,
           let description = view?.descriptionText, !description.isEmpty,
           let image = view?.selectedButtonImage
        {
            guard let context = CoreDataManager().context else { return }
            let newList = Recipes(context: context)
            newList.title = title
            newList.ingredients = ingredients
            newList.descriptions = description
            newList.savedImage = image
            CoreDataManager().createTask()
            view?.showProgressHUD()
            view?.tabBarSelectedIndex(2)
        } else {
            view?.setAlert()
        }
    }
    func didTapSelectImageButton() {
        view?.setImagePicker()
    }
}
