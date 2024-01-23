//
//  LeaderboardViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 1/22/24.
//

import UIKit
import Combine
import SnapKit

class LeaderboardViewController: UIViewController {
    
    private lazy var pedestalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.pedestal.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.black  // Change the color to your preference
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(LeaderboardViewCell.self,
                           forCellReuseIdentifier: LeaderboardViewCell.cellID)
        tableView.backgroundColor = AppColor.beige.uiColor
        return tableView
    }()
    
    var users: [(username: String, learningScore: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        navigationController?.navigationBar.isHidden = true
        fetchUsers()
        view.addSubview(pedestalImageView)
        view.addSubview(tableView)
        tableView.reloadData()
        configureConstraints()
    }
    
    private func fetchUsers() {
        DatabaseManager.shared.collectionUsers { user in
            print("All users: \(user)")
            self.users = user.sorted(by: { (user1, user2) -> Bool in
                if let score1 = Int(user1.learningScore), let score2 = Int(user2.learningScore) {
                    return score1 > score2
                }
                return false
            })
            self.tableView.reloadData()
        }
    }
    
    private func configureConstraints() {
        pedestalImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(180)
            make.width.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(pedestalImageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardViewCell.cellID,
                                                       for: indexPath) as? LeaderboardViewCell else {
            fatalError("Unable to dequeue LeaderboardViewCell")
        }
        
        let user = users[indexPath.row]
        cell.configure(place: indexPath.row, username: user.username, learningScore: user.learningScore)
        
        return cell
    }
}
