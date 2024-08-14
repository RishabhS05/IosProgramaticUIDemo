//
//  FavoritesViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 31/07/24.
//

import UIKit

class FavoritesListViewController: BaseNetworkViewController {
    
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
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorites.isEmpty{
            var config  = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: SfSymbols.star)
            config.text = "No Favorites"
            config.secondaryText = "Add a favorite on the follower list screen"
            contentUnavailableConfiguration = config
        }else {
            contentUnavailableConfiguration = nil
        }
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
        PersistenceManager.retrieveFovorites{ [weak self]
            result in
            guard let self = self else { return }
            switch result {
                case .success(let favorites):
                    print(favorites)
                        self.favorites = favorites
                    setNeedsUpdateContentUnavailableConfiguration()
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.view.bringSubviewToFront(self.tableView)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: UIFavoriteViewCell.reuseID) as! UIFavoriteViewCell
        let favorite = self.favorites[indexPath.row]
        cell.set(favorite:favorite)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersViewController(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        PersistenceManager.updatewith(favorite: favorite, actionType: .remove){
            [weak self ] error in
            guard let self else { return }
            guard let error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                setNeedsUpdateContentUnavailableConfiguration()
                return
            }
            presentGptAlert(title: "Unable to Remove", message: error.rawValue, buttonTitle: "Oops")
        }
    }
}

#Preview{
    FavoritesListViewController()
}
