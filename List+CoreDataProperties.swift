//
//  List+CoreDataProperties.swift
//  CocktailRecipes
//
//  Created by Kaan Yeyrek on 12/23/22.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var title: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var descriptions: String?

}

extension List : Identifiable {

}
