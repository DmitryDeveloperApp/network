//
//  NetworkManager.swift
//  Networking
//
//  Created by Dmitry Suprun on 23.05.2022.
//

import Foundation


class NetworkManager {
    
    enum HTTPMethod: String {
        case POST
        case PUT
        case GET
        case DELETE
    }
    
    enum APIs: String{
        case posts
        case users
        case comments
    }
    private let baseURL = "http://jsonplaceholder.typicode.com/"
    
    
    func getAllPosts(_ complitionHandler: @escaping ([Post])-> Void) {
        if let url = URL(string: baseURL + APIs.posts.rawValue) {
         
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("error in request")
                }else {
                    if let resp = response as? HTTPURLResponse,resp.statusCode == 200,
                    let responseData = data{
                        
                        let posts = try? JSONDecoder().decode([Post].self, from: responseData)
                     
                        complitionHandler(posts ?? [])
                    }
                }
            }.resume()
            
        }
    }
    
    func postCreatePost(_ post: Post, complitionHandler: @escaping (Post)->Void) {
        
        let sendData = try? JSONEncoder().encode(post)
        
        guard let url = URL(string: baseURL + APIs.posts.rawValue),
        let data = sendData
        else {
            return
        }
        
        let request = MutableURLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Lengh")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, responce, error in
            
            if error != nil {
                print("error")
            } else if let resp = responce as? HTTPURLResponse,
                      resp.statusCode == 201, let responseData = data {
                
                if  let responsePost = try? JSONDecoder().decode(Post.self, from: responseData) {
                    complitionHandler(responsePost)
                }
            }
            
        }.resume()
    }
    func getPostBy(userId: Int, complitionHander: @escaping ([Post])->Void) {
        guard let url = URL(string: baseURL + APIs.posts.rawValue) else { return}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
        
        guard let queryURL = components?.url else {return}
        URLSession.shared.dataTask(with: queryURL) { data, response, error in
            if error != nil {
                print("Error getPostBy")
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 200, let reciveData = data {
                let posts = try? JSONDecoder().decode([Post].self, from: reciveData)
                
                complitionHander(posts ?? [])
            }
        }
    }
}
