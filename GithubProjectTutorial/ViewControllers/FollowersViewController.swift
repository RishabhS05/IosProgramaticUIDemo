//
//  FollowersViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 02/08/24.
//   

protocol FollowersViewDelegate  : AnyObject {
    func  didRequestFollowers(for username : String)
}

import UIKit
class FollowersViewController: BaseNetworkViewController {
    var  username: String!
    var collectionView : UICollectionView! //
    var followers : [Follower] = []
    var filteredFollowers : [Follower] = []
    var page : Int  = 1
    var hasMoreFollowers = true
    var isSearching  = false
    var isLoadingMoreFollowers  = false
    
    enum Section {// enums are by default hashable
        case main
     }
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowersV2(page: page)
        configureDataSource()
    }
    
    init(username : String){
        super.init(nibName: nil , bundle: nil )
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if followers.isEmpty && !isLoadingMoreFollowers  {
            var config  = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: SfSymbols.personSlash)
            config.text = "No Followers"
            config.secondaryText = "\(String(describing: username)) Has no followers. Please Go and follow."
            contentUnavailableConfiguration = config
        } else if isSearching && filteredFollowers.isEmpty{
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        }
        else {
            contentUnavailableConfiguration = nil
        }
    }
    
    
    /// configuring Initial UIViewController
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavV2))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addToFavV2() {
        showLoadingView()
        Task{
            do{
                let user  = try await NetworkManagerV2.shared.getUser(username: username)
                let favorite = Follower(login: user.login,avatarUrl: user.avatarUrl)
                PersistenceManager.updatewith(favorite: favorite, actionType: .add ){ [ weak self] err in
                    guard let self else { return }
                    guard let err else {
                        self.presentGptAlertOnMainThread(title: "Success", message: "You have successfully added \(user.login) to your favorite list.", buttonTitle: "Ok")
                        return
                    }
                    self.presentGptAlertOnMainThread(title: "Hi 😄", message: err.rawValue, buttonTitle: "Ok")
                }
            }catch{
                if let gfError =  error as? GPTError {
                    presentGptAlert(title:"Something went wrong!!", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentGptDefaultError()
                }
            }
        }
     dismissLoadingView()
   }
    
         //Old Api call with NetworkManager
 @objc func addToFav(){
     showLoadingView()
     NetworkManager.shared.getUser(username: username){  [weak self]result in
         guard let self  = self else { return }
         self.dismissLoadingView()
         switch result {
             case .success(let user):
                 let favorite = Follower(login: user.login , avatarUrl: user.avatarUrl)
                 
                 PersistenceManager.updatewith(favorite: favorite, actionType: .add ){ [weak self] err in
                   
                     guard let self = self else { return }
                     
                     guard let err = err else {
                         self.presentGptAlert(title: "Success", message: "You have successfully added \(user.login) to your favorite list.", buttonTitle: "Ok")
                         return
                     }
                     self.presentGptAlert(title: "Hi 😄", message: err.rawValue, buttonTitle: "Ok")
                 }
    
             case .failure(let err):
                 self.presentGptAlertOnMainThread(title:"Something went wrong!!", message: err.rawValue, buttonTitle: "Ok")
                 
         }
     }
}
    func updateUI(on followers : [Follower]){
        if followers.count < 100 { hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        updateData(on: followers)
        setSearchControllerLabel()
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
        isLoadingMoreFollowers = true
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
        isLoadingMoreFollowers = false
    }
    
        ///  get Follower Api call initated
        /// - Parameter page: Page number is passed for pagination
        func getFollowersV2(page : Int){ // api call
            showLoadingView()
            isLoadingMoreFollowers = true
            Task{
                do{
                    let followers = try await NetworkManagerV2.shared.getFollowers(for: username, page: page)
                    print(followers)
                    updateUI(on: followers)
                    setNeedsUpdateContentUnavailableConfiguration()

                }
                catch {
                    if let gfError = error as? GPTError {
                       presentGptAlert(title: "ERROR", message: gfError.rawValue, buttonTitle: "OK")
                    } else {
                        presentGptDefaultError()
                    }
                }
                isLoadingMoreFollowers = false
                dismissLoadingView()
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
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        page = 1
    }
}

extension FollowersViewController : UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        if offsetY > contentHeight - frameHeight && hasMoreFollowers && !isLoadingMoreFollowers  {
            page += 1
            getFollowersV2(page: page)
            print("Calling Api for next")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeList =  isSearching ? filteredFollowers : followers
        let follower = activeList[indexPath.item]
        let destVC = UserInfoViewController()
        destVC.delegate = self
        destVC.username = follower.login
        let navigationController = UINavigationController(rootViewController: destVC)
        present(navigationController , animated: true)
        
    }
}

extension FollowersViewController : UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        isSearching = true
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { 
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        filteredFollowers=followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

extension FollowersViewController : FollowersViewDelegate{
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        resetScreen()
        getFollowersV2(page: 1)
    }
}

#Preview {
    FollowersViewController(username: "SAllen0400")
}
