//
//  NetworkManager.swift
//  GithubProjectTutorial
//
//  Basic Native way to call an Api.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let BASE_URL = "https://api.github.com/users/"
    private init() {}
    
    func getFollowers(for username : String, page: Int, completed: @escaping ([Follower]?, ErrorMessages?)-> Void){
        let endpoint = BASE_URL + "\(username)/followers?per_page=\(page)"
        
        guard let url = URL(string : endpoint) else {
            completed(nil, .usernameInvalid)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .checkInternet)
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
            guard let data = data else {
                completed(nil,.serverDataInvalid)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from:data)
                completed(followers, nil)
            }
            catch{
                completed(nil, .serverDataInvalid)
            }
            
        }
        task.resume() // this will start the network call
    }
}
