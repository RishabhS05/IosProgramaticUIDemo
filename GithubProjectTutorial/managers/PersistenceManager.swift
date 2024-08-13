//
//  PersistanceManager.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 11/08/24.
//

import Foundation

enum PersistenceActionType { case add ,remove }
enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys{static let favorites = "favorites"}
    
    static func updatewith(favorite : Follower, actionType : PersistenceActionType, completed : @escaping(GPTError?)-> Void){
        retrieveFovorites{ result in
            switch result {
                case .success(var favorites):
                    
                    switch actionType {
                        case .add :
                            guard !favorites.contains(favorite) else {
                                completed(.alreadyFav)
                                return
                            }
                            favorites.append(favorite)
                        case .remove:
                            favorites.removeAll{$0.login == favorite.login}
                    }
                    completed(save(favorites: favorites))
                case .failure(let error) : completed(error)
            }
        }
        
    }
    
    static func retrieveFovorites(completed : @escaping (Result<[Follower],GPTError>)-> Void){
        guard let favData = defaults.object(forKey: Keys.favorites)  as? Data  else{
            completed(.success([]))
            return
        }
    
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favData)
            completed(.success(favorites))
            
        } catch {
            completed(.failure(.invalidFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GPTError? {
        do{
            let encoder  = JSONEncoder()
            let encoderFav = try encoder.encode(favorites)
            defaults.set(encoderFav, forKey: Keys.favorites)
            return nil
        } catch {return .invalidFavorite}
    }
}
