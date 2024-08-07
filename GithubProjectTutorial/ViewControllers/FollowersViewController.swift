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
    enum Section {// enums are by default hashable
        case main
     }
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
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
    
    func create3columnFlowLayput() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding : CGFloat = 12
        let mininumItemSpace : CGFloat = 10
        let availableWidth = width - (padding * 2) - (mininumItemSpace * 2)
        let itemwidth = availableWidth / 3
        let flowLayout  = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize  = CGSize(width: itemwidth, height: itemwidth + 40 )
        return flowLayout
    }
    func getFollowers(){ // api call
        NetworkManager.shared.getFollowers(for: username, page: 100){
          result in
            switch (result){
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error) :
                self.presentGptAlertOnMainThread(title: "ERROR", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: create3columnFlowLayput())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView?.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuserId)
        
    }

}

