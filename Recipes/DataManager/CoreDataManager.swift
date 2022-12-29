//
//  CoreDataManager.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/23/22.
//
import CoreData
import UIKit

protocol CoreDataManagerInterface {
    func createTask()
    func fetchRecipes() -> [Recipes]?
    func delete(entity: Recipes)
}

final class CoreDataManager {
    var context: NSManagedObjectContext? {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        return context
    }
}
extension CoreDataManager: CoreDataManagerInterface {
        func createTask() {
            do {
                try context?.save()
            } catch {
               print("failed create")
            }
        }
        func fetchRecipes() -> [Recipes]? {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
            do {
                let fetchedRecipes = try context?.fetch(fetchRequest) as? [Recipes]
                return fetchedRecipes?.reversed()
            } catch {
                fatalError("failed fetch: \(error)")
            }
        }
        func delete(entity: Recipes) {
            context?.delete(entity)
            try? context?.save()
        }
    }

