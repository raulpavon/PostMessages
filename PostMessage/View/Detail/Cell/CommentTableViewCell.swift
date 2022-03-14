//
//  CommentTableViewCell.swift
//  PostMessage
//
//  Created by Raúl Pavón on 11/03/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    enum CommentTableViewCellConstraints {
        enum LbComment {
            static let fontSize: CGFloat = 14
            static let top: CGFloat = 10
            static let leading: CGFloat = 5
            static let trailing: CGFloat = -5
            static let bottom: CGFloat = -10
        }
    }
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lbComment: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: CommentTableViewCellConstraints.LbComment.fontSize)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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
        mainContainer.addSubview(lbComment)
    }
    
    private func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lbComment.topAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.topAnchor, constant: CommentTableViewCellConstraints.LbComment.top),
            lbComment.leadingAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.leadingAnchor, constant: CommentTableViewCellConstraints.LbComment.leading),
            lbComment.trailingAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.trailingAnchor, constant: CommentTableViewCellConstraints.LbComment.trailing),
            lbComment.bottomAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.bottomAnchor, constant: CommentTableViewCellConstraints.LbComment.bottom),
        ])
    }
    
    func fillComment(comment: String) {
        lbComment.text = comment
    }
}
