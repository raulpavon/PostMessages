//
//  PostViewModel.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import Foundation
import UIKit

class PostViewModelImp: PostViewModel {
    enum Favorite: Int {
        case isFavorite = 1
        case noFavorite = 0
    }
    
    weak var view: PostView?
    let postRepository: PostRepository
    private var post = [Post]()
    private var user = User()
    private var comment = [Comment]()
    private var favorites: [String: String] = UserDefaults.standard.object(forKey: GlobalConstants.PostMessage.UserDefaults.favorites) as? [String: String] ?? [:]
    
    required init(view: PostView, postRepository: PostRepository) {
        self.view = view
        self.postRepository = postRepository
    }
    
    func getPostList() {
        postRepository.getPosts {
            [weak self] response in
            self?.post = response
            self?.view?.fillPostList(post: self?.post ?? [])
        }
    }
    
    func getPostUser(id: Int) {
        postRepository.getPostUser(userId: id) {
            [weak self] response in
            self?.user = response
            self?.view?.fillUserInfo(user: self?.user ?? User())
        }
    }
    
    func getPostComment(id: Int) {
        postRepository.getPostComment(postId: id) {
            [weak self] response in
            self?.comment = response
            self?.view?.fillComments(comment: self?.comment ?? [])
        }
    }
    
    func getFavorites() -> [String : String] {
        return UserDefaults.standard.object(forKey: GlobalConstants.PostMessage.UserDefaults.favorites) as? [String: String] ?? [:]
    }
    
    func addFavorite(id: Int) {
        if favorites["\(id)"] == nil || favorites["\(id)"] == "\(Favorite.noFavorite.rawValue)" {
            favorites["\(id)"] = "\(Favorite.isFavorite.rawValue)"
            UserDefaults.standard.set(favorites, forKey: GlobalConstants.PostMessage.UserDefaults.favorites)
        } else if favorites ["\(id)"] == "\(Favorite.isFavorite.rawValue)" {
            favorites["\(id)"] = "\(Favorite.noFavorite.rawValue)"
            UserDefaults.standard.set(favorites, forKey: GlobalConstants.PostMessage.UserDefaults.favorites)
        }
    }
}
