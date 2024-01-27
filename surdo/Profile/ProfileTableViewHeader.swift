//
//  ProfileTableViewHeader.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/5/23.
//

import UIKit

class ProfileTableViewHeader: UITableViewHeaderFooterView {
    weak var delegate: TableViewHeaderDelegate?
    static let identifier = "ProfileTableViewHeader"
    
    private enum SectionTabs: String {
        case achivements = "Achivements"
        case settings = "Settings"
        
        var index: Int {
            switch self {
            case .achivements:
                return 0
            case .settings:
                return 1
            }
        }
        
    }
    
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.red.uiColor
        return view
    }()
    
    private var selectedTab: Int = 0 {
        didSet {
            for index in 0..<tabs.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.sectionStack.arrangedSubviews[index].tintColor = index ==
                    self?.selectedTab ? .label : .secondaryLabel
                    self?.leadingAnchors[index].isActive = index == self?.selectedTab ? true : false
                    self?.trailingAnchors[index].isActive = index == self?.selectedTab ? true : false
                    self?.layoutIfNeeded()
                } completion: { _ in
                    
                }
            }
        }
    }
    private var tabs: [UIButton] = [ "Achievements", "Settings" ]
        .map { buttonTitle in
            let button = UIButton(type: .system)
            switch buttonTitle {
            case "Achievements":
                button.setTitle("Достижение", for: .normal)
            case "Settings":
                button.setTitle("Настройки", for: .normal)
            default:
                button.setTitle(" ", for: .normal)
            }
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = .label
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    var joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.text = "Загрузка"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let joinDateImageView: UIImageView = {
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
    
    var levelCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "0"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var userBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Загрузка"
        return label
    }()
    
    var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.text = "Загрузка"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    var displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = "Загрузка"
        return label
    }()
    
    var profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppImage.profileTab.systemImage
        return imageView
    }()
    
    lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Политика конфидециальности", for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        button.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = AppColor.beige.uiColor
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userBioLabel)
        addSubview(joinDateImageView)
        addSubview(joinDateLabel)
        addSubview(levelTextLabel)
        addSubview(levelCountLabel)
        addSubview(privacyPolicyButton)
        addSubview(sectionStack)
        addSubview(indicator)
        configureConstraints()
        configureStackButton()
    }
    
    private func configureStackButton() {
        for (i, button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            if i == selectedTab {
                button.tintColor = .label
            } else {
                button.tintColor = .secondaryLabel
            }
            button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        switch label {
        case "Достижение":
            selectedTab = 0
        case "Настройки":
            selectedTab = 1
        default:
            selectedTab = 0
        }
    }
    
    @objc private func didTapPrivacyPolicyButton() {
        delegate?.didTapPrivacyPolicyButton()
    }
    
    // swiftlint: disable all
    private func configureConstraints() {
        for i in 0..<tabs.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(
                equalTo: sectionStack.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(
                equalTo: sectionStack.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let displayNameLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor,
                                                      constant: 20),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor,
                                                  constant: 20)
        ]
        let usernameLabelConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
        ]
        let userBioLabelConstraints = [
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5)
        ]
        let joinDateImageViewConstraints = [
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5)
        ]
        let joinDateLabelConstraints = [
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 2),
            joinDateLabel.bottomAnchor.constraint(equalTo: joinDateImageView.bottomAnchor)
        ]
        let followersCountLabelConstraints = [
            levelCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            levelCountLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor, constant: 10)
        ]
        let followersTextLabelConstraints = [
            levelTextLabel.leadingAnchor.constraint(equalTo: levelCountLabel.trailingAnchor,
                                                    constant: 2),
            levelTextLabel.topAnchor.constraint(equalTo: joinDateLabel.bottomAnchor,
                                                constant: 10)
        ]
        
        let privacyPolicyButtonConstraints = [
            privacyPolicyButton.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            privacyPolicyButton.topAnchor.constraint(equalTo: levelTextLabel.bottomAnchor,
                                                     constant: 10)
        ]
        
        let sectionStackConstraints = [
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            sectionStack.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor, constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let indicatorConstraints = [
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ]
        
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
        NSLayoutConstraint.activate(userBioLabelConstraints)
        NSLayoutConstraint.activate(joinDateImageViewConstraints)
        NSLayoutConstraint.activate(joinDateLabelConstraints)
        NSLayoutConstraint.activate(followersTextLabelConstraints)
        NSLayoutConstraint.activate(followersCountLabelConstraints)
        NSLayoutConstraint.activate(privacyPolicyButtonConstraints)
        NSLayoutConstraint.activate(sectionStackConstraints)
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    // swiftlint: enable all
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

protocol TableViewHeaderDelegate: AnyObject {
    func didTapPrivacyPolicyButton()
}
