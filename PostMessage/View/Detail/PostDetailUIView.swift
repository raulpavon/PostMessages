//
//  PostDetailUIView.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import UIKit

class PostDetailUIView: UIView {
    enum PostDetailUIViewConstraints {
        enum LbDescriptionTitle {
            static let fontSize: CGFloat = 20
            static let top: CGFloat = 10
            static let leading: CGFloat = 15
            static let trailing: CGFloat = -15
        }
        enum LbDescription {
            static let fontSize: CGFloat = 13
            static let top: CGFloat = 10
        }
        enum LbUser {
            static let fontSize: CGFloat = 20
            static let top: CGFloat = 15
        }
        enum StackViewLabel {
            static let fontSize: CGFloat = 13
        }
        enum StackView {
            static let top: CGFloat = 10
            static let bottom: CGFloat = -30
        }
        enum TableViewComment {
            static let top : CGFloat = 30
        }
    }
    
    var comment = [Comment]()
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var lbDescriptionTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = GlobalConstants.PostMessage.LbDescriptionTitle.title
        label.textColor = .black
        label.font = .systemFont(ofSize: PostDetailUIViewConstraints.LbDescriptionTitle.fontSize, weight: .bold)
        return label
    }()
    
    private lazy var lbDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: PostDetailUIViewConstraints.LbDescription.fontSize)
        return label
    }()
    
    private lazy var lbUser: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = GlobalConstants.PostMessage.LbUser.title
        label.textColor = .black
        label.font = .systemFont(ofSize: PostDetailUIViewConstraints.LbUser.fontSize, weight: .bold)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var lbName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: PostDetailUIViewConstraints.StackViewLabel.fontSize)
        return label
    }()
    
    private lazy var lbEmail: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: PostDetailUIViewConstraints.StackViewLabel.fontSize)
        return label
    }()
    
    private lazy var lbPhone: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: PostDetailUIViewConstraints.StackViewLabel.fontSize)
        return label
    }()
    
    private lazy var lbWeb: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: PostDetailUIViewConstraints.StackViewLabel.fontSize)
        return label
    }()
    
    lazy var tableViewComment: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initComponents() {
        addComponents()
        setAutolayout()
        setUp()
    }
    
    private func addComponents() {
        addSubview(mainContainer)
        mainContainer.addSubview(lbDescriptionTitle)
        mainContainer.addSubview(lbDescription)
        mainContainer.addSubview(lbUser)
        mainContainer.addSubview(stackView)
        stackView.addArrangedSubview(lbName)
        stackView.addArrangedSubview(lbEmail)
        stackView.addArrangedSubview(lbPhone)
        stackView.addArrangedSubview(lbWeb)
        mainContainer.addSubview(tableViewComment)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lbDescriptionTitle.topAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.topAnchor, constant: PostDetailUIViewConstraints.LbDescriptionTitle.top),
            lbDescriptionTitle.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: PostDetailUIViewConstraints.LbDescriptionTitle.leading),
            lbDescriptionTitle.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: PostDetailUIViewConstraints.LbDescriptionTitle.trailing),
            
            lbDescription.topAnchor.constraint(equalTo: lbDescriptionTitle.bottomAnchor, constant: PostDetailUIViewConstraints.LbDescription.top),
            lbDescription.leadingAnchor.constraint(equalTo: lbDescriptionTitle.leadingAnchor),
            lbDescription.trailingAnchor.constraint(equalTo: lbDescriptionTitle.trailingAnchor),
            
            lbUser.topAnchor.constraint(equalTo: lbDescription.bottomAnchor, constant: PostDetailUIViewConstraints.LbUser.top),
            lbUser.leadingAnchor.constraint(equalTo: lbDescriptionTitle.leadingAnchor),
            lbUser.trailingAnchor.constraint(equalTo: lbDescriptionTitle.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: lbUser.bottomAnchor, constant: PostDetailUIViewConstraints.StackView.top),
            stackView.leadingAnchor.constraint(equalTo: lbDescriptionTitle.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: lbDescriptionTitle.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: tableViewComment.topAnchor, constant: PostDetailUIViewConstraints.StackView.bottom),
            
            tableViewComment.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: PostDetailUIViewConstraints.TableViewComment.top),
            tableViewComment.leadingAnchor.constraint(equalTo: lbDescriptionTitle.leadingAnchor),
            tableViewComment.trailingAnchor.constraint(equalTo: lbDescriptionTitle.trailingAnchor),
            tableViewComment.bottomAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUp() {
        tableViewComment.delegate = self
        tableViewComment.dataSource = self
    }
    
    func fillDescription(description: String) {
        lbDescription.text = description
    }
    
    func fillUserInfo(user: User) {
        lbName.text = "\(GlobalConstants.PostMessage.UserInfo.name) \(user.name)"
        lbEmail.text = "\(GlobalConstants.PostMessage.UserInfo.email) \(user.email)"
        lbPhone.text = "\(GlobalConstants.PostMessage.UserInfo.phone) \(user.phone)"
        lbWeb.text = "\(GlobalConstants.PostMessage.UserInfo.web) \(user.website)"
    }
}

extension PostDetailUIView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        cell.fillComment(comment: comment[indexPath.row].body)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return GlobalConstants.PostMessage.TableViewHeader.title
    }
}
