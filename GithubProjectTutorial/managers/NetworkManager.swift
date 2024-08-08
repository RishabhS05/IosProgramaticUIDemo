//
//  NetworkManager.swift
//  GithubProjectTutorial
//
//  Basic Native way to call an Api.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let BASE_URL = "https://api.github.com/users/"
    let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username : String, page: Int, completed: @escaping (Result<[Follower], GPTError>)-> Void){
        let endpoint = BASE_URL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string : endpoint) else {
            completed(.failure(.usernameInvalid))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.checkInternet))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.serverDataInvalid))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from:data)
                completed(.success(followers))
            }
            catch{
                completed(.failure(.serverDataInvalid))
            }
            
        }
        task.resume() // this will start the network call
    }
}
