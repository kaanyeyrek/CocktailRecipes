//
//  DataManager.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/13/22.
//

import Foundation
// Service
protocol DataManagerInterface {
    func parse(completion: @escaping ([Drink]?) -> ())
}
//MARK: - Data parsing // Service
final class DataManager: DataManagerInterface {
    static let shared = DataManager()
    init() {}
    func parse(completion: @escaping ([Drink]?) -> ()) {
        let apiKey = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?g=Champagne_flute")
        URLSession.shared.dataTask(with: apiKey!) { data, response, error in
            if error != nil {
                print("failed parse")
                return
            }
            do {
                let result = try JSONDecoder().decode(Cocktail.self, from: data!)
                completion(result.drinks)
            } catch {
            }
        }.resume()
    }
}
