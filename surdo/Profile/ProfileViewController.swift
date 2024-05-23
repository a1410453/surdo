//
//  ProfileViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/5/23.
//

import UIKit
import Combine
import SDWebImage
import FirebaseAuth

final class ProfileViewController: UIViewController, TableViewHeaderDelegate {
    private var isStatusBarHidden: Bool = true
    private var viewModel = ProfileViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private lazy var statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.beige.uiColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var headerView = ProfileTableViewHeader(frame: CGRect(x: 0,
                                                                       y: 0,
                                                                       width: profileTableView.frame.width,
                                                                       height: 450))
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AchievementsViewCell.self, forCellReuseIdentifier: AchievementsViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        navigationItem.title = NSLocalizedString("Profile.profile", comment: "")
        view.addSubview(profileTableView)
        view.addSubview(statusBar)
        
        profileTableView.backgroundColor = AppColor.beige.uiColor
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.tableHeaderView = headerView
        headerView.delegate = self
        profileTableView.contentInsetAdjustmentBehavior = .never
        navigationController?.navigationBar.isHidden = true
        configureConstraints()
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrieveUser()
        profileTableView.reloadData()
    }
    
    private func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            self?.headerView.displayNameLabel.text = user.fullName
            self?.headerView.usernameLabel.text = "@\(user.username)"
            let text = "\(NSLocalizedString("Profile.scored", comment: "")) \(user.learningScore)"
            self?.headerView.userBioLabel.text = text
            self?.headerView.profileAvatarImageView.sd_setImage(with: URL(string: user.avatarPath))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM YYYY"
            dateFormatter.locale = .current
            let text1 = dateFormatter.string(from: user.createdOn).capitalized
            self?.headerView.joinDateLabel.text =
                                """
                                \(text1) \(NSLocalizedString("Profile.started", comment: ""))
                                """
            let text2 = NSLocalizedString("Profile.lessonCompleted", comment: "")
            self?.headerView.levelCountLabel.text = "\(user.learningProgress)"
            self?.headerView.levelTextLabel.text = "\(text2)"
        }
        .store(in: &subscriptions)
    }
    
    private func configureConstraints() {
        let profileTableViewConstraints = [
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let statusBarConstraints = [
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: view.bounds.height > 800 ? 40 : 20)
            
        ]
        NSLayoutConstraint.activate(profileTableViewConstraints)
        NSLayoutConstraint.activate(statusBarConstraints)
    }
    
    func didTapPrivacyPolicyButton() {
        let controller = PrivacyPolicyViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapSignOutButton() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AchievementsManager.achievements.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AchievementsViewCell.identifier,
                                                       for: indexPath) as? AchievementsViewCell else {
            return UITableViewCell()
        }
        cell.isUserInteractionEnabled = false
        if indexPath.row == AchievementsManager.achievements.count {
            return cell
        } else {
            cell.configureTweet(with: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition > 150 && isStatusBarHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            } completion: { _ in }
        } else if yPosition < 0 && !isStatusBarHidden {
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            } completion: { _ in }
            
        }
    }
    
}
