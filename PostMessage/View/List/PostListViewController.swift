//
//  PostListViewController.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import UIKit

class PostListViewController: UIViewController {
    
    weak var postCoordinator: PostCoordinator?
    private let factory: PostFactory
    
    private lazy var postListUIView: PostListUIView = {
        let view = PostListUIView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewModel: PostViewModel = {
        let viewModel = factory.makePostViewModel(view: self, repository: factory.makePostRepository())
        return viewModel
    }()
    
    required init(factory: PostFactory, postCoordinator: PostCoordinator) {
        self.factory = factory
        self.postCoordinator = postCoordinator
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
        viewModel.getPostList()
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
        let btRefresh = UIBarButtonItem(image: UIImage(systemName: GlobalConstants.Images.refresh), style: .plain, target: self, action: #selector(refresh))
        btRefresh.tintColor = .white
        navigationItem.rightBarButtonItem = btRefresh
    }
    
    private func initComponents() {
        addComponents()
        setAutolayout()
    }
    
    private func addComponents() {
        view.addSubview(postListUIView)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            postListUIView.topAnchor.constraint(equalTo: view.topAnchor),
            postListUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postListUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postListUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func refresh() {
        DispatchQueue.main.async {
            self.postListUIView.tableViewPost.reloadData()
        }
    }
}

extension PostListViewController: PostView {
    func fillUserInfo(user: User) {
        
    }
    
    func fillComments(comment: [Comment]) {
        
    }
    
    func fillPostList(post: [Post]) {
        postListUIView.setPosts(post: post)
    }
    
    func goToPostDetail(id: Int, userId: Int, detail: String) {
        postCoordinator?.openPostDetail(id: id, userId: userId, detail: detail)
    }
}

extension PostListViewController: PostListUIViewDelegate {
    func goToPostDetail(postId: Int, userId: Int, detail: String) {
        postCoordinator?.openPostDetail(id: postId, userId: userId, detail: detail)
    }
}
