//
//  NetworkManagerV2.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 13/08/24.
//

import UIKit

class NetworkManagerV2 {
    
    // it comes in ios 15 network calls with async await.
    static let shared = NetworkManagerV2()
    private let BASE_URL = "https://api.github.com/users/"
    let imageCache = NSCache<NSString , UIImage>()
    private let decoder = JSONDecoder()

    private init (){
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
        /// New Network Call get followers of the current users api
        /// - Parameters:
        ///   - username: takes the current user name as input
        ///   - page: used for pagnation
        ///   - completed: It is the callback method to provide the response of the api call.
    
    func getFollowers(for username : String, page: Int ) async throws -> [Follower] {
        let endpoint = BASE_URL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string : endpoint) else { throw GPTError.usernameInvalid }
        let (data ,response ) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GPTError.invalidResponse
        }
        do { return try decoder.decode([Follower].self, from:data) }
        catch{
            throw   GPTError.serverDataInvalid
        }
    }
    
    
    
        ///User profile Api : - get the user detailed infomation api ca
        /// - Parameters:
        ///   - username: (login) field as username param
        ///   - completed: Return User object in case of successful api call
    func getUser(username : String) async throws -> User {
        let endpoint = BASE_URL+"\(username)"
        
        guard let url = URL(string : endpoint) else {
            throw GPTError.usernameInvalid
        }
        let (data , response ) = try await URLSession.shared.data(from : url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GPTError.invalidResponse
        }
        do {
            return try decoder.decode(User.self, from: data)
        }
        catch  {
            throw GPTError.serverDataInvalid
        }
    }
    
    
        /// Network call to get image for avatar and also caching it
        /// - Parameters:
        ///   - url: url to retrieve it
    func downloadImage(from url : String ) async -> UIImage? {
        let cachekey = NSString(string : url)
        if let image = imageCache.object(forKey: cachekey){ return image }
        
        guard let url = URL(string: url) else { return nil }
        
        do {
            let (data , response)  = try await URLSession.shared.data(from : url)
            guard let response = response as? HTTPURLResponse,response.statusCode == 200,
                  let image = UIImage(data: data) else {
                return  nil
           }
            imageCache.setObject(image, forKey: cachekey)
            return image
        } catch {
            return nil
        }
    }
}
