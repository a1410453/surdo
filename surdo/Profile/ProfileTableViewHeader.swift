//
//  ProfileTableViewHeader.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/5/23.
//

import UIKit

// swiftlint: disable all
final class ProfileTableViewHeader: UITableViewHeaderFooterView {
    weak var delegate: TableViewHeaderDelegate?
    static let identifier = "ProfileTableViewHeader"
    
    // MARK: UI
    private lazy var achievementsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColor.red.uiColor
        label.text = NSLocalizedString("Profile.achievements", comment: "")
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.text = NSLocalizedString("Common.loading", comment: "")
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
        label.text = "0"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var levelCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = NSLocalizedString("Common.loading", comment: "")
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var userBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = NSLocalizedString("Common.loading", comment: "")
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.text = NSLocalizedString("Common.loading", comment: "")
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = NSLocalizedString("Common.loading", comment: "")
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
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        configuration.imagePadding = 8
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Profile.privacy", comment: ""), for: .normal)
        button.setImage(AppImage.privacy.systemImage, for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        button.setTitleColor( .label, for: .normal)
        button.backgroundColor = AppColor.tabbar.uiColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private lazy var supportButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        configuration.imagePadding = 8
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Profile.support", comment: ""), for: .normal)
        button.setImage(AppImage.support.systemImage, for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        button.setTitleColor( .label, for: .normal)
        button.backgroundColor = AppColor.tabbar.uiColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapSupportButton), for: .touchUpInside)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        configuration.imagePadding = 8
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Profile.logOut", comment: ""), for: .normal)
        button.setImage(AppImage.signOut.systemImage, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        button.setTitleColor( .label, for: .normal)
        button.backgroundColor = AppColor.tabbar.uiColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private lazy var deleteAccountButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        configuration.imagePadding = 8
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Profile.deleteAccount", comment: ""), for: .normal)
        button.setImage(AppImage.deleteAccount.systemImage, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        button.setTitleColor( .label, for: .normal)
        button.backgroundColor = AppColor.tabbar.uiColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapDeleteAccount), for: .touchUpInside)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    // MARK: Setup Views
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        [ profileAvatarImageView, displayNameLabel, usernameLabel, userBioLabel, joinDateImageView,
          joinDateLabel, levelTextLabel, levelCountLabel, privacyPolicyButton, supportButton,
          signOutButton, achievementsLabel, deleteAccountButton
        ].forEach {
            addSubview($0)
        }
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
        configureLevelTextLabelConstraints()
        configureLevelCountLabelConstraints()
        configurePrivacyPolicyButtonConstraints()
        configureSupportButtonConstraints()
        configureSignoutButtonConstraints()
        configureAchievementsLabelConstraints()
        configureDeleteAccountButtonConstraints()
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
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(usernameLabelConstraints)
    }
    
    private func configureUserBioLabelConstraints() {
        let userBioLabelConstraints = [
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(userBioLabelConstraints)
    }
    
    private func configureJoinDateImageViewConstraints() {
        let joinDateImageViewConstraints = [
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 10)
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
    
    private func configureLevelTextLabelConstraints() {
        let levelTextLabelConstraints = [
            levelTextLabel.leadingAnchor.constraint(equalTo: levelCountLabel.trailingAnchor,
                                                    constant: 2),
            levelTextLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor,
                                                constant: 10)
        ]
        NSLayoutConstraint.activate(levelTextLabelConstraints)
    }
    
    private func configureLevelCountLabelConstraints() {
        let LevelCountLabelConstraints = [
            levelCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            levelCountLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(LevelCountLabelConstraints)
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
    
    private func configureSignoutButtonConstraints() {
        let signOutButtonConstraints = [
            signOutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            signOutButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -30),
            signOutButton.topAnchor.constraint(equalTo: supportButton.bottomAnchor,
                                               constant: 10),
            signOutButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(signOutButtonConstraints)
    }
    
    private func configureDeleteAccountButtonConstraints() {
        let deleteAccountButtonConstraints = [
            deleteAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            deleteAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -30),
            deleteAccountButton.topAnchor.constraint(equalTo: signOutButton.bottomAnchor,
                                               constant: 10),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(deleteAccountButtonConstraints)
    }
    
    private func configureAchievementsLabelConstraints() {
        let achievementsLabelConstraints = [
            achievementsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            achievementsLabel.topAnchor.constraint(equalTo: deleteAccountButton.bottomAnchor, constant: 40)
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
    
    @objc private func didTapSignOut() {
        delegate?.didTapSignOutButton()
    }
    
    @objc private func didTapDeleteAccount() {
        delegate?.didTapDeleteAccountButton()
    }
}

protocol TableViewHeaderDelegate: AnyObject {
    func didTapPrivacyPolicyButton()
    func didTapSignOutButton()
    func didTapDeleteAccountButton()
}

// swiftlint: enable all
