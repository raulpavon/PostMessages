//
//  PostFactory.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import Foundation

protocol PostFactory {
    func makePostListViewController(postCoordinator: PostCoordinator) -> PostListViewController
    func makePostDeatailViewController(postCoordinator: PostCoordinator, id: Int, userId: Int, detail: String) -> PostDetailViewController
    func makePostViewModel(view: PostView, repository: PostRepository) -> PostViewModel
    func makePostRepository() -> PostRepository
}

class PostFactoryImp: PostFactory {

    func makePostListViewController(postCoordinator: PostCoordinator) -> PostListViewController {
        let postListViewController = PostListViewController(factory: self, postCoordinator: postCoordinator)
        return postListViewController
    }
    
    func makePostDeatailViewController(postCoordinator: PostCoordinator, id: Int, userId: Int, detail: String) -> PostDetailViewController {
        let postDetailViewController = PostDetailViewController(factory: self, postCoordinator: postCoordinator, id: id, userId: userId, detail: detail)
        return postDetailViewController
    }
   
    func makePostViewModel(view: PostView, repository: PostRepository) -> PostViewModel {
        let viewModel = PostViewModelImp(view: view, postRepository: repository)
        return viewModel
    }
    
    func makePostRepository() -> PostRepository  {
        let repository = PostRepository()
        return repository
    }
}
