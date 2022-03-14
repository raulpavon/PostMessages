//
//  PostListUIView.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import UIKit

protocol PostListUIViewDelegate: AnyObject {
    func goToPostDetail(postId: Int, userId: Int, detail: String)
}

class PostListUIView: UIView {
    enum PostListUIViewConstraints {
        enum SegmentedControl {
            static let top: CGFloat = 10
            static let leading: CGFloat = 25
            static let trailing: CGFloat = -25
            static let height: CGFloat = 35
        }
        enum TableViewPost {
            static let top: CGFloat = 10
            static let leading: CGFloat = 10
            static let trailing: CGFloat = -10
        }
        enum BtnDelete {
            static let height: CGFloat = 50
        }
    }
    
    weak var delegate: PostListUIViewDelegate?
    var posts = [Post]()
    var favoritesDictionary = [String: String]()
    var favoritePosts = [Post]()
    var isFavorite = false
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: [GlobalConstants.PostMessage.SegmentedControl.segmentOne, GlobalConstants.PostMessage.SegmentedControl.segmentTwo])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectedSegmentIndex = 0
        segmented.selectedSegmentTintColor = .green
        segmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmented.setTitleTextAttributes([.foregroundColor: UIColor.green], for: .normal)
        segmented.backgroundColor = .white
        segmented.addTarget(self, action: #selector(segmentedChanged), for: .valueChanged)
        return segmented
    }()
    
    lazy var tableViewPost: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var btDelete: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(GlobalConstants.PostMessage.BtDelete.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initComponents() {
        addComponents()
        setAutolayout()
        setUp()
    }
    
    private func addComponents() {
        addSubview(mainContainer)
        mainContainer.addSubview(segmentedControl)
        mainContainer.addSubview(tableViewPost)
        mainContainer.addSubview(btDelete)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.topAnchor, constant: PostListUIViewConstraints.SegmentedControl.top),
            segmentedControl.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: PostListUIViewConstraints.SegmentedControl.leading),
            segmentedControl.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: PostListUIViewConstraints.SegmentedControl.trailing),
            segmentedControl.heightAnchor.constraint(equalToConstant: PostListUIViewConstraints.SegmentedControl.height),
            
            tableViewPost.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: PostListUIViewConstraints.TableViewPost.top),
            tableViewPost.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: PostListUIViewConstraints.TableViewPost.leading),
            tableViewPost.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: PostListUIViewConstraints.TableViewPost.trailing),
            tableViewPost.bottomAnchor.constraint(equalTo: btDelete.topAnchor),
            
            btDelete.topAnchor.constraint(equalTo: tableViewPost.bottomAnchor),
            btDelete.centerXAnchor.constraint(equalTo: centerXAnchor),
            btDelete.heightAnchor.constraint(equalToConstant: PostListUIViewConstraints.BtnDelete.height),
            btDelete.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            btDelete.bottomAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    private func setUp() {
        tableViewPost.delegate = self
        tableViewPost.dataSource = self
    }
    
    @objc private func segmentedChanged() {
        isFavorite = !isFavorite
        favoritePosts = []
        if isFavorite {
            if favoritesDictionary.count > 0 {
                favoritesDictionary = UserDefaults.standard.object(forKey: "favorites") as? [String: String] ?? [:]
                let sortedFavDictionary = favoritesDictionary.sorted(by: <)
                for i in 0...sortedFavDictionary.count - 1 {
                    let post = posts.filter { $0.id == Int(sortedFavDictionary[i].key) }
                    favoritePosts.append(contentsOf: post)
                }
            }
        }
        tableViewPost.reloadData()
    }
    
    func setPosts(post: [Post]) {
        posts = post
        DispatchQueue.main.async {
            self.tableViewPost.reloadData()
        }
    }
    
    @objc func deletePressed() {
        tableViewPost.removeFromSuperview()
    }
    
    func setSegmentedControlTarget(target: Any?, action: Selector) {
        segmentedControl.addTarget(target, action: action, for: .valueChanged)
    }
}

extension PostListUIView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFavorite ? favoritePosts.count : posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        isFavorite ? cell.fillPost(post: favoritePosts[indexPath.row]) : cell.fillPost(post: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isFavorite ? delegate?.goToPostDetail(postId: favoritePosts[indexPath.row].id, userId: favoritePosts[indexPath.row].userId, detail: favoritePosts[indexPath.row].body) : delegate?.goToPostDetail(postId: posts[indexPath.row].id, userId: posts[indexPath.row].userId, detail: posts[indexPath.row].body)
    }
}
