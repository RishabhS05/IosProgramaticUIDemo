//
//  FollowersViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 02/08/24.
//   

import UIKit
protocol FollowersViewDelegate  : class {
    func  didRequestFollowers(for username : String)
}

class FollowersViewController: UIViewController {
    var  username: String!
    var collectionView : UICollectionView! //
    var followers : [Follower] = []
    var filteredFollowers : [Follower] = []
    var page : Int  = 1
    var hasMoreFollowers = true
    var isSearching  = false
    
    enum Section {// enums are by default hashable
        case main
     }
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    /// configuring Initial UIViewController
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {
           (collectionView , indexpath , follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuserId, for: indexpath) as! FollowersCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    /// Configuring search Controller and attaching into the navigationItem
    func configureSearchController(){
        let searchController  = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    /// wanted to show current followerslist count.
    func setSearchControllerLabel(){
        DispatchQueue.main.async {
            self.navigationItem.searchController?.searchBar.placeholder = "Search username from \(self.followers.count) followers"
        }
    }
    
    func updateData(on followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
//      runing in main thread
//        DispatchQueue.main.async{
//            self.dataSource.apply(snapshot,animatingDifferences: true)
//        }
        // below code : - According to SAllen its will give us worning on running in background thread
        // work fine without any warning.
        self.dataSource.apply( snapshot,animatingDifferences: true)
      
    }
    
    ///  get Follower Api call initated
    /// - Parameter page: Page number is passed for pagination
    func getFollowers(page : Int){ // api call
        
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page){ [weak self]
          result in
            // as weak object is always optional so to by pass this we use guard statement.
            guard let self = self else { return }
             dismissLoadingView()
            switch (result){
            case .success(let followers):
                if followers.count < 100 {hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if  self.followers.isEmpty{ let message = "This user doesn't have any followers Go follow then 😀"
                    DispatchQueue.main.async{ self.showEmptyStateView(with: message, in: self.view)
                    }
                }
                self.updateData(on : self.followers)
                setSearchControllerLabel()
            case .failure(let error) :
                self.presentGptAlertOnMainThread(title: "ERROR", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: Uihelper.create3columnFlowLayput(in : view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView?.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuserId)
    }
    private func resetScreen(){
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        page = 1
    }
}

extension FollowersViewController : UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        if offsetY > contentHeight - frameHeight && hasMoreFollowers {
            page += 1
            getFollowers(page: page)
            print("Calling Api for next")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeList =  isSearching ? filteredFollowers : followers
        let follower = activeList[indexPath.item]
        let destVC = UserIInfoViewController()
        destVC.delegate = self
        destVC.username = follower.login
        let navigationController = UINavigationController(rootViewController: destVC)
        present(navigationController , animated: true)
        
    }
}

extension FollowersViewController : UISearchResultsUpdating, UISearchBarDelegate  {
    
    func updateSearchResults(for searchController: UISearchController) {
        isSearching = true
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers=followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
    
}

extension FollowersViewController : FollowersViewDelegate{
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        resetScreen()
        getFollowers(page: 1)
    }
}
