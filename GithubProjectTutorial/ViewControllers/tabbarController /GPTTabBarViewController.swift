//
//  GPTTabBarViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 11/08/24.
//

import UIKit

class GPTTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(),createFavoritesNavigationController()]
    }
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search,tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    func createFavoritesNavigationController() -> UINavigationController {
        let favVC = FavoritesListViewController()
        favVC.title = "Favorites"
        favVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites,tag: 1)
        return UINavigationController(rootViewController: favVC)
    }
    
}
