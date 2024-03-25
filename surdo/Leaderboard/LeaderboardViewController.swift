//
//  LeaderboardViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 1/22/24.
//

import UIKit
import Combine
import SnapKit

final class LeaderboardViewController: UIViewController {
    
    private lazy var pedestalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.pedestal.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var leaderboardTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.black
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
        view.addSubview(pedestalImageView)
        view.addSubview(leaderboardTableView)
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
        leaderboardTableView.reloadData()
        createParticles()
    }
    
    func fetchUsers() {
        DatabaseManager.shared.collectionUsers { user in
            self.users = user.sorted(by: { (user1, user2) -> Bool in
                if let score1 = Int(user1.learningScore), let score2 = Int(user2.learningScore) {
                    return score1 > score2
                }
                return false
            })
            self.leaderboardTableView.reloadData()
        }
    }
    
    private func configureConstraints() {
        pedestalImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(180)
            make.width.equalToSuperview()
        }
        
        leaderboardTableView.snp.makeConstraints { make in
            make.top.equalTo(pedestalImageView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()

        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -20)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width/2, height: 1)

        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: AppColor.red.uiColor)

        particleEmitter.emitterCells = [red, green, red]

        pedestalImageView.layer.addSublayer(particleEmitter)
    }

    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 100
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.scale = 0.4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.2
        cell.scaleSpeed = -0.05

        cell.contents = UIImage(named: "confetti")?.cgImage
        cell.color = color.cgColor
        
        return cell
    }
}

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardViewCell.cellID,
                                                       for: indexPath) as? LeaderboardViewCell else {
            fatalError("Unable to dequeue LeaderboardViewCell")
        }
        
        let user = users[indexPath.row]
        cell.configure(place: indexPath.row, 
                       username: user.username,
                       learningScore: user.learningScore)
        return cell
    }
}
