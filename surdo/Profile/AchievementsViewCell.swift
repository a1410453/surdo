//
//  TweetTableViewCell.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/5/23.
//

import UIKit
import SnapKit

final class AchievementsViewCell: UITableViewCell {

    static let identifier = "AchievementsViewCell"
    
    private let actionSpacing: CGFloat = 400
    
    private let achievementTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = " "
        label.font = AppFont.semibold.s20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let achievementDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = " "
        label.font = AppFont.regular.s16()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = AppColor.red.uiColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = AppColor.beige.uiColor
        contentView.addSubview(achievementTitleLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(achievementDescriptionLabel)
        contentView.addSubview(lineView)
        configureConstraints()
    }
    
    func configureTweet(with index: Int) {
        achievementTitleLabel.text = AchievementsManager.achievementTitles[index]
        achievementDescriptionLabel.text = AchievementsManager.achievementDescriptions[index]
        avatarImageView.image = AppImage(rawValue: "achievement\(index)")?.uiImage
    }
    
    private func configureConstraints() {
        let avatarImageViewConstraints = [
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 250),
            avatarImageView.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        let achievementDescriptionLabelConstraints = [
            achievementDescriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,
                                                             constant: 20),
            achievementDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, 
                                                                 constant: 30),
            achievementDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                                  constant: -30)
        ]
        
        let achievementTitleLabelConstraints = [
            achievementTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            achievementTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ]
        
        let lineViewConstraints = [
            lineView.topAnchor.constraint(equalTo: topAnchor,
                                                             constant: 10),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                                 constant: 30),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                                  constant: -30),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(achievementDescriptionLabelConstraints)
        NSLayoutConstraint.activate(achievementTitleLabelConstraints)
        NSLayoutConstraint.activate(lineViewConstraints)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
