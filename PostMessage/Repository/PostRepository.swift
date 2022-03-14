//
//  PostRepository.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import Foundation

class PostRepository {
    enum PostRepositoryURL {
        static let posts = "https://jsonplaceholder.typicode.com/posts"
        static let user = "https://jsonplaceholder.typicode.com/users/"
        static let comments = "/comments"
    }
    
    enum HttpMethod {
        static let get = "GET"
    }
    
    func getPosts(_ completionHandler: @escaping ([Post]) -> Void) {
        if let requestURL = URL(string: PostRepositoryURL.posts) {
            var request = URLRequest(url: requestURL)
            request.httpMethod = HttpMethod.get
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    print("Error fetching posts: \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let response = try JSONDecoder().decode([Post].self, from: data)
                    completionHandler(response)
                } catch {
                    print("Error decoding posts: \(error)")
                    return
                }
            }.resume()
        }
    }
    
    func getPostUser(userId: Int, _ completionHandler: @escaping (User) -> Void) {
        if let requestURL = URL(string: "\(PostRepositoryURL.user)\(userId)") {
            var request = URLRequest(url: requestURL)
            request.httpMethod = HttpMethod.get
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    print("Error fetching user: \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let response = try JSONDecoder().decode(User.self, from: data)
                    completionHandler(response)
                } catch {
                    print("Error decoding user: \(error)")
                    return
                }
            }.resume()
        }
    }
    
    func getPostComment(postId: Int, _ completionHandler: @escaping ([Comment]) -> Void) {
        if let requestURL = URL(string: "\(PostRepositoryURL.posts)/\(postId)\(PostRepositoryURL.comments)") {
            var request = URLRequest(url: requestURL)
            request.httpMethod = HttpMethod.get
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    print("Error fetching comments: \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let response = try JSONDecoder().decode([Comment].self, from: data)
                    completionHandler(response)
                } catch {
                    print("Error decoding comments: \(error)")
                    return
                }
            }.resume()
        }
    }
}
