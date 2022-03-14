//
//  PostCoordinator.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import Foundation
import UIKit

class PostCoordinator {
    var navigationController: UINavigationController
    private let factory =  PostFactoryImp()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postListViewController = factory.makePostListViewController(postCoordinator: self)
        navigationController.setViewControllers([postListViewController], animated: false)
    }
    
    func openPostDetail(id: Int, userId: Int, detail: String) {
        let postDetailViewController = factory.makePostDeatailViewController(postCoordinator: self, id: id, userId: userId, detail: detail)
        navigationController.pushViewController(postDetailViewController, animated: true)
    }
}
