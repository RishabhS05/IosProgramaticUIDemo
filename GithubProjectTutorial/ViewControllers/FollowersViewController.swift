//
//  FollowersViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 02/08/24.
//   

import UIKit

class FollowersViewController: UIViewController {
    var  username: String!
    var collectionView : UICollectionView! //
    var followers : [Follower] = []
    var page : Int  = 1
    var hasMoreFollowers = true
    enum Section {// enums are by default hashable
        case main
     }
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
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
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
//      runing in main thread
//      DispatcherQueue.main.async{
//            self.dataSource.apply( snapshot,animatingDifferences: true)
//        }
        // below code : - According to Allen its will give us worning on running in background thread
        // work fine without any warning.
        self.dataSource.apply( snapshot,animatingDifferences: true)
    }

    func getFollowers(page : Int){ // api call
        
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page){ [weak self]
          result in
            // as weak object is always optional so to by pass this we use guard statement.
            guard let self = self else { return }
            self.dismissLoadingView()
            switch (result){
            case .success(let followers):
                if followers.count < 100 {hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData()
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
}
