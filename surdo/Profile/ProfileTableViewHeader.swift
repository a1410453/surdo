//
//  ProfileTableViewHeader.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/5/23.
//

import UIKit

final class ProfileTableViewHeader: UITableViewHeaderFooterView {
    weak var delegate: TableViewHeaderDelegate?
    static let identifier = "ProfileTableViewHeader"

    // MARK: UI
    private lazy var achievementsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColor.red.uiColor
        label.text = "Достижения"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.text = "Загрузка"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var levelTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "уроков пройдено"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var levelCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "0"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var userBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Загрузка"
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.text = "Загрузка"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = "Загрузка"
        return label
    }()
    
    lazy var profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppImage.profileTab.systemImage
        return imageView
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Политика конфидециальности", for: .normal)
        button.setImage(AppImage.privacy.systemImage, for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        button.setTitleColor( .label, for: .normal)
        button.backgroundColor = AppColor.tabbar.uiColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var supportButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сообщить о проблеме", for: .normal)
        button.setImage(AppImage.support.systemImage, for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        button.setTitleColor( .label, for: .normal)
        button.backgroundColor = AppColor.tabbar.uiColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapSupportButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Setup Views
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userBioLabel)
        addSubview(joinDateImageView)
        addSubview(joinDateLabel)
        addSubview(levelTextLabel)
        addSubview(levelCountLabel)
        addSubview(privacyPolicyButton)
        addSubview(supportButton)
        addSubview(achievementsLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup Constraints
    private func configureConstraints() {
        configureProfileAvatarImageViewConstraints()
        configureDisplayNameLabelConstraints()
        configureUsernameLabelConstraints()
        configureUserBioLabelConstraints()
        configureJoinDateImageViewConstraints()
        configureJoinDateLabelConstraints()
        configureFollowersTextLabelConstraints()
        configureFollowersCountLabelConstraints()
        configurePrivacyPolicyButtonConstraints()
        configureSupportButtonConstraints()
        configureAchievementsLabelConstraints()
    }
    
    private func configureProfileAvatarImageViewConstraints() {
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
    }
    
    private func configureDisplayNameLabelConstraints() {
        let displayNameLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor,
                                                      constant: 20),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor,
                                                  constant: 20)
        ]
        NSLayoutConstraint.activate(displayNameLabelConstraints)
    }
    
    private func configureUsernameLabelConstraints() {
        let usernameLabelConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
        ]
        NSLayoutConstraint.activate(usernameLabelConstraints)
    }
    
    private func configureUserBioLabelConstraints() {
        let userBioLabelConstraints = [
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5)
        ]
        NSLayoutConstraint.activate(userBioLabelConstraints)
    }
    
    private func configureJoinDateImageViewConstraints() {
        let joinDateImageViewConstraints = [
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5)
        ]
        NSLayoutConstraint.activate(joinDateImageViewConstraints)
    }
    
    private func configureJoinDateLabelConstraints() {
        let joinDateLabelConstraints = [
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 2),
            joinDateLabel.bottomAnchor.constraint(equalTo: joinDateImageView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(joinDateLabelConstraints)
    }
    
    private func configureFollowersTextLabelConstraints() {
        let followersTextLabelConstraints = [
            levelTextLabel.leadingAnchor.constraint(equalTo: levelCountLabel.trailingAnchor,
                                                    constant: 2),
            levelTextLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor,
                                                constant: 10)
        ]
        NSLayoutConstraint.activate(followersTextLabelConstraints)
    }
    
    private func configureFollowersCountLabelConstraints() {
        let followersCountLabelConstraints = [
            levelCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            levelCountLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(followersCountLabelConstraints)
       
    }
    
    private func configurePrivacyPolicyButtonConstraints() {
        let privacyPolicyButtonConstraints = [
            privacyPolicyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            privacyPolicyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            privacyPolicyButton.topAnchor.constraint(equalTo: levelTextLabel.bottomAnchor,
                                                     constant: 10),
            privacyPolicyButton.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        NSLayoutConstraint.activate(privacyPolicyButtonConstraints)
    }
    
    private func configureSupportButtonConstraints() {
        let supportButtonConstraints = [
            supportButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            supportButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -30),
            supportButton.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor,
                                                     constant: 10),
            supportButton.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        NSLayoutConstraint.activate(supportButtonConstraints)
    }
    
    private func configureAchievementsLabelConstraints() {
        let achievementsLabelConstraints = [
            achievementsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            achievementsLabel.topAnchor.constraint(equalTo: supportButton.bottomAnchor, constant: 60)
        ]
        NSLayoutConstraint.activate(achievementsLabelConstraints)
    }
    
    // MARK: Actions
    @objc private func didTapPrivacyPolicyButton() {
        delegate?.didTapPrivacyPolicyButton()
    }
    
    @objc private func didTapSupportButton() {
        if let url = URL(string: "https://t.me/rickby999") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

protocol TableViewHeaderDelegate: AnyObject {
    func didTapPrivacyPolicyButton()
}
