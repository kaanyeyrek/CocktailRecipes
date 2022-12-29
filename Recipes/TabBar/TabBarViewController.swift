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
        let listVC = ListViewController()
        let addNewRecipeVC = AddNewRecipeViewController()
        
        homeVC.title = "Welcome!"
        categoriesVC.title = "Categories"
        listVC.title = "My List"
        addNewRecipeVC.title = "New Recipe"
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let categoriesNav = UINavigationController(rootViewController: categoriesVC)
        let listNav = UINavigationController(rootViewController: listVC)
        let addNewRecipeNav = UINavigationController(rootViewController: addNewRecipeVC)
        
        homeNav.navigationBar.backgroundColor = .clear
        self.tabBar.backgroundColor = .white
        homeNav.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(15), for: UIBarMetrics.default)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 25)!]
        homeNav.navigationBar.titleTextAttributes = attributes
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        categoriesNav.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "circle.grid.2x2"), tag: 1)
        listNav.tabBarItem = UITabBarItem(title: "My List", image: UIImage(systemName: "heart.fill"), tag: 2)
        addNewRecipeNav.tabBarItem = UITabBarItem(title: "Add Recipe", image: UIImage(systemName: "plus"), tag: 3)
        
        
        setViewControllers([homeNav, categoriesNav, listNav, addNewRecipeNav], animated: true)
    }

}
