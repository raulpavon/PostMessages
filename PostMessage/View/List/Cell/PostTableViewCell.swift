//
//  PostTableViewCell.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    enum PostTableViewCellConstraints {
        enum LbPost {
            static let fontSize: CGFloat = 16
            static let top: CGFloat = 10
            static let leading: CGFloat = 15
            static let width: CGFloat = 300
            static let bottom: CGFloat = -10
        }
        enum ImArrow {
            static let height: CGFloat = 25
            static let trailing: CGFloat = -15
        }
    }
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lbPost: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: PostTableViewCellConstraints.LbPost.fontSize)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let imgArrow: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: GlobalConstants.Images.arrow)?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .gray
        return image
    }()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initComponents()
    }
    
    private func initComponents() {
        addComponents()
        setAutolayout()
    }
    
    private func addComponents() {
        addSubview(mainContainer)
        mainContainer.addSubview(lbPost)
        mainContainer.addSubview(imgArrow)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lbPost.topAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.topAnchor, constant: PostTableViewCellConstraints.LbPost.top),
            lbPost.leadingAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.leadingAnchor, constant: PostTableViewCellConstraints.LbPost.leading),
            lbPost.widthAnchor.constraint(equalToConstant: PostTableViewCellConstraints.LbPost.width),
            lbPost.bottomAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.bottomAnchor, constant: PostTableViewCellConstraints.LbPost.bottom),
            
            imgArrow.heightAnchor.constraint(equalToConstant: PostTableViewCellConstraints.ImArrow.height),
            imgArrow.centerYAnchor.constraint(equalTo: lbPost.centerYAnchor),
            imgArrow.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: PostTableViewCellConstraints.ImArrow.trailing)
        ])
    }
    
    func fillPost(post: Post) {
        lbPost.text = post.title
    }
}
