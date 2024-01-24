//
//  TweetTableViewCell.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/5/23.
//

import UIKit
import SnapKit

class AchievementsViewCell: UITableViewCell {

    static let identifier = "AchievementsViewCell"
    
    private let actionSpacing: CGFloat = 400
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "You learned all letters!"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = AppColor.beige.uiColor
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        
        configureConstraints()
    }
    
    func configureTweet(with displayName: String, 
                        username: String,
                        tweetTextContent: String,
                        avatarPath: String) {
        // displayNameLabel.text = displayName
        // usernameLabel.text =  
        // tweetTextContentLabel.text = tweetTextContent
        // avatarImageView.sd_setImage(with: URL(string: avatarPath))
    }
    
    private func configureConstraints() {
        let avatarImageViewConstraints = [
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 300),
            avatarImageView.widthAnchor.constraint(equalToConstant: 300)
        ]

        let usernameLabelConstraints = [
            usernameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
