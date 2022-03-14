//
//  PostProtocols.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import Foundation

protocol PostView: AnyObject {
    func fillPostList(post: [Post])
    func goToPostDetail(id: Int, userId: Int, detail: String)
    func fillUserInfo(user: User)
    func fillComments(comment: [Comment])
}

protocol PostViewModel {
    func getPostList()
    func getPostUser(id: Int)
    func getPostComment(id: Int)
    func getFavorites() -> [String: String]
    func addFavorite(id: Int)
}
