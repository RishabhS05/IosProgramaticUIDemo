//
//  FavoritesViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 31/07/24.
//

import UIKit

class FavoritesListViewController: UIViewController {
    let  tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        getFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }

    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.register(UIFavoriteViewCell.self, forCellReuseIdentifier: UIFavoriteViewCell.reuseID)
    }
    
    func  getFavorites(){
        PersistanceManager.retrieveFovorites{ [weak self]
            result in
            guard let self = self else { return }
            switch result {
                case .success(let favorites):
                    print(favorites)
                   
                    if favorites.isEmpty {
                        showEmptyStateView(with: "No Favorites?\n Add the followers as yor favorites.", in: self.view)
                    } else {
                        self.favorites = favorites
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.view.bringSubviewToFront(self.tableView)
                        }
                    }
                case .failure(let error):
                    self.presentGptAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavoritesListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        print("\n\n\n\n| \(self.favorites[indexPath.row])")
        let cell = tableView.dequeueReusableCell(withIdentifier: UIFavoriteViewCell.reuseID) as! UIFavoriteViewCell
        let favorite = self.favorites[indexPath.row]
        cell.set(favorite:favorite)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersViewController()
        destVC.username = favorite.login
        destVC.title = favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
         
        PersistanceManager.updatewith(favorite: favorite, actionType: .remove){
            [weak self ] error in
            guard let self = self else { return }
            guard let error  = error else { return }
            self.presentGptAlertOnMainThread(title: "Unable to Remove", message: error.rawValue, buttonTitle: "Oops")
        }
    }
}
