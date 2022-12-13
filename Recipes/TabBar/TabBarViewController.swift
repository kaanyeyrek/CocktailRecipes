//
//  TabBarViewController.swift
//  Recipes
//
//  Created by Kaan Yeyrek on 12/10/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarConfig()
    }
    // set UITabbarItem
    fileprivate func setTabBarConfig() {
        let homeVC = HomeViewController()
        let categoriesVC = CategoriesViewController()
        let favoritesVC = FavoritesViewController()
        let addNewRecipeVC = AddNewRecipeViewController()
        
        homeVC.title = "Search"
        categoriesVC.title = "Categories"
        favoritesVC.title = "Favorites"
        addNewRecipeVC.title = "New Recipe"
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let categoriesNav = UINavigationController(rootViewController: categoriesVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        let addNewRecipeNav = UINavigationController(rootViewController: addNewRecipeVC)
        
        homeNav.navigationBar.backgroundColor = .clear
        self.tabBar.backgroundColor = .white
        homeNav.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(15), for: UIBarMetrics.default)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 25)!]
        homeNav.navigationBar.titleTextAttributes = attributes
        
        homeNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        categoriesNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "circle.grid.2x2"), tag: 1)
        favoritesNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart.fill"), tag: 2)
        addNewRecipeNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 3)
        
        
        setViewControllers([homeNav, categoriesNav, favoritesNav, addNewRecipeNav], animated: true)
    }

}
