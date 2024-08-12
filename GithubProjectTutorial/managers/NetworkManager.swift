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
    
        /// Call get followers  of the current users api
        /// - Parameters:
        ///   - username: takes the current user name as input
        ///   - page: used for pagnation
        ///   - completed: It is the callback method to provide the response of the api call.
    
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
                decoder.dateDecodingStrategy = .iso8601
                let followers = try decoder.decode([Follower].self, from:data)
                completed(.success(followers))
            }
            catch{
                completed(.failure(.serverDataInvalid))
            }
            
        }
        task.resume() // this will start the network call
    }
    
    
        ///User profile Api : - get the user detailed infomation api ca
        /// - Parameters:
        ///   - username: (login) field as username param
        ///   - completed: Return User object in case of successful api call
    func getUser(username : String, completed : @escaping (Result<User, GPTError>) -> Void){
        let endpoint = BASE_URL+"\(username)"
        print(endpoint)
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
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }
            catch  {
                print(error)
                completed(.failure(.serverDataInvalid))
            }
            
        }
        task.resume()
    }
    
    func downloadImage(from url : String , completed : @escaping(UIImage?) -> Void){
        
        let cachekey = NSString(string : url)
        
        if let image = imageCache.object(forKey: cachekey){
          completed(image)
            return
        }
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data ,response ,error in
             guard let self = self ,error == nil,
            let response = response as? HTTPURLResponse,response.statusCode == 200,
            let data  = data,
            let image = UIImage(data: data) else {
                 completed(nil)
                 return
             }

            imageCache.setObject(image, forKey: cachekey)
            
            completed(image)
                
        }
        task.resume()
    }
}
