//
//  LeaderboardViewCell.swift
//  surdo
//
//  Created by Rustem Orazbayev on 1/22/24.
//

import UIKit

final class LeaderboardViewCell: UITableViewCell {
    static let cellID = "LeaderboardCell"

    private let placeLabel = UILabel()
    private let usernameLabel = UILabel()
    private let scoreLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = AppColor.beige.uiColor
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(usernameLabel)

        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scoreLabel)

        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            scoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(place: Int,username: String, learningScore: String) {
        usernameLabel.text = "\(place + 1). " + username
        scoreLabel.text = NSLocalizedString("Leaderboard.points", comment: "") + learningScore
    }
}
