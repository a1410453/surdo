//
//  WordController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 6/8/24.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseAuth
import FirebaseStorage
import Combine

final class WordController: UIViewController {
    
    var letter = " "
    var currentWord = 0
    var topic = 0
    var onDismiss: (() -> Void)?
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var error: String = ""
    
    // MARK: UI components
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Common.loading", comment: "")
        label.textColor = AppColor.red.uiColor
        label.font = AppFont.bold.s37()
        return label
    }()
    
    private lazy var repeatButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.red.uiColor
        button.tintColor = AppColor.beige.uiColor
        button.setTitle(NSLocalizedString("Common.Button.repeat", comment: ""), for: .normal)
        button.titleLabel?.font = AppFont.medium.s24()
        button.addTarget(self, action: #selector(tappedRepeatButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.red.uiColor
        button.tintColor = AppColor.beige.uiColor
        button.setTitle(NSLocalizedString("Common.Button.next", comment: ""), for: .normal)
        button.titleLabel?.font = AppFont.medium.s24()
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var containerView = UIView()
    private lazy var player: AVPlayer = {
        switch topic {
        case 2:
            ManagerAPI.wordTopic = "%2FA%2FA"
        case 3:
            ManagerAPI.wordTopic = "%2FB%2FB"
        case 4:
            ManagerAPI.wordTopic = "%2FC%2FC"
        default:
            ManagerAPI.wordTopic = "%2FA%2FA"
        }
        let player = AVPlayer(url: ManagerAPI.makeWordURL(middlePart: currentWord))
        return player
    }()
    private var playerLayer: AVPlayerLayer!
    
    var counterOfRepetitions = 0
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        nextButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupViews()
        setupConstraints()
        setupVideo()
        nextButton.isHidden = true
        repeatButton.isHidden = true
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(levelLabel)
        view.addSubview(repeatButton)
        view.addSubview(nextButton)
        view.addSubview(containerView)
    }

    private func setupConstraints() {
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(-250)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        repeatButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    
    private func setupVideo() {
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.frame = self.view.bounds.insetBy(dx: 20, dy: 0)
        containerView.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidStartPlaying(_:)),
                                               name: AVPlayerItem.newAccessLogEntryNotification,
                                               object: player.currentItem)
        player.play()
    }
    
    // MARK: Action
    @objc func tappedNextButton() {
        // dismiss
        updateUserScore()
        unlockNextLevel()
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func tappedRepeatButton() {
        player.seek(to: CMTime.zero)
        player.play()
    }
    
    private func updateUserScore() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        let updatedFields: [String: Any] = [
            "learningScore": "\(LevelAccessManager.learningScore)",
            "learningProgress": "\(LevelAccessManager.currentLevel)"
        ]
        
        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                    self?.error = error.localizedDescription
                }
            } receiveValue: { _ in
            }
            .store(in: &subscriptions)
    }
    
    private func unlockNextLevel() {
        if LevelAccessManager.currentLevel == 0 {
            AchievementsManager.achievements.append(1)
        }
        if LevelAccessManager.currentLevel == 42 {
            AchievementsManager.achievements.append(2)
            LevelAccessManager.currentSection = 1
        }
        if LevelAccessManager.currentLevel == 43 {
            AchievementsManager.achievements.append(3)
        }
        if LevelAccessManager.currentLevel == 82 {
            AchievementsManager.achievements.append(3)
            LevelAccessManager.currentSection = 2
        }
        if LevelAccessManager.currentLevel == 173 {
            AchievementsManager.achievements.append(3)
        }
        LevelAccessManager.currentLevel += 1
        LevelAccessManager.shared.unlockLevelAccess()
    }
    
    @objc func playerDidFinishPlaying(_ notification: Notification) {
        if counterOfRepetitions < 2 {
            player.seek(to: CMTime.zero)
            player.play()
            counterOfRepetitions += 1
        } else {
            counterOfRepetitions = 0
            player.pause()
            nextButton.isHidden = false
            repeatButton.isHidden = false
        }
    }
    
    @objc func playerDidStartPlaying(_ notification: Notification) {
        switch topic {
        case 2:
            levelLabel.text = NSLocalizedString("Acquaintance\(currentWord-1)",
                                                comment: "")
        case 3:
            levelLabel.text = NSLocalizedString("Person\(currentWord-1)",
                                                comment: "")
        case 4:
            levelLabel.text = NSLocalizedString("home\(currentWord-1)",
                                                comment: "")
        default:
            levelLabel.text = NSLocalizedString("Common.downloadError",
                                                comment: "")
        }

    }
}
