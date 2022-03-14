//
//  PostDetailViewController.swift
//  PostMessage
//
//  Created by Raúl Pavón on 11/03/22.
//

import UIKit
import CoreData

class PostDetailViewController: UIViewController {
    enum Favorite: Int {
        case isFavorite = 1
        case notFavorite = 0
    }
    
    weak var postCoordinator: PostCoordinator?
    private let factory: PostFactory
    private var id: Int
    private var userId: Int
    private var detail: String
    
    private lazy var postDetailUIView: PostDetailUIView = {
        let view = PostDetailUIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewModel: PostViewModel = {
        let viewModel = factory.makePostViewModel(view: self, repository: factory.makePostRepository())
        return viewModel
    }()
    
    required init(factory: PostFactory, postCoordinator: PostCoordinator, id: Int, userId: Int, detail: String) {
        self.factory = factory
        self.postCoordinator = postCoordinator
        self.id = id
        self.userId = userId
        self.detail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        initComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPostUser(id: userId)
        viewModel.getPostComment(id: id)
        postDetailUIView.fillDescription(description: detail)
    }
    
    private func setNavBar() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .green
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            self.navigationController?.navigationBar.barTintColor = .green
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        self.title = GlobalConstants.PostMessage.title
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: GlobalConstants.Images.back), style: .plain, target: self, action: #selector(backPressed))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        setFavoriteButton()
    }
    
    private func initComponents() {
        addComponents()
        setAutolayout()
    }
    
    private func addComponents() {
        view.addSubview(postDetailUIView)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            postDetailUIView.topAnchor.constraint(equalTo: view.topAnchor),
            postDetailUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postDetailUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postDetailUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addFavorite() {
        viewModel.addFavorite(id: id)
        setFavoriteButton()
    }
    
    func setFavoriteButton() {
        let favorites = viewModel.getFavorites()
        if favorites["\(id)"] != nil || Int(favorites["\(id)"] ?? "") == Favorite.notFavorite.rawValue {
            let favButton = UIBarButtonItem(image: UIImage(systemName: GlobalConstants.Images.starFill), style: .plain, target: self, action: #selector(addFavorite))
            favButton.tintColor = .white
            navigationItem.rightBarButtonItem = favButton
        }  else {
            let favButton = UIBarButtonItem(image: UIImage(systemName: GlobalConstants.Images.star), style: .plain, target: self, action: #selector(addFavorite))
            favButton.tintColor = .white
            navigationItem.rightBarButtonItem = favButton
        }
    }
}

extension PostDetailViewController: PostView {
    func fillUserInfo(user: User) {
        DispatchQueue.main.async {
            self.postDetailUIView.fillUserInfo(user: user)
        }
    }
    
    func fillComments(comment: [Comment]) {
        postDetailUIView.comment = comment
        DispatchQueue.main.async {
            self.postDetailUIView.tableViewComment.reloadData()
        }
    }
    
    func goToPostDetail(id: Int, userId: Int, detail: String) {
        
    }
    
    func fillPostList(post: [Post]) {
        
    }
}
