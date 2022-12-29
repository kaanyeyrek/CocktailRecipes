//
//  Recipes+CoreDataProperties.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/23/22.
//
//

import Foundation
import CoreData


extension Recipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipes> {
        return NSFetchRequest<Recipes>(entityName: "Recipes")
    }

    @NSManaged public var title: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var savedImage: Data?

}

extension Recipes : Identifiable {

}
