//
//  LetterController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//

import UIKit
import AVKit
import AVFoundation

final class LetterController: UIViewController {
    
    var letter = " "
    var currentLetter = 0
    var onDismiss: (() -> Void)?
    
    // MARK: UI components    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Common.loading", comment: "")
        label.textColor = AppColor.red.uiColor
        label.font = AppFont.bold.s37()
        return label
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
        ManagerAPI.middle = currentLetter + 1
        let player = AVPlayer(url: ManagerAPI.makeURL())
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
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(levelLabel)
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
        let viewController = QuizViewController()
        viewController.passCurrentLetter(currentLetter)
        navigationController?.pushViewController(viewController, animated: true)
        viewController.onDismiss = { [weak self] in
            self?.tabBarController?.tabBar.isHidden = false
            self?.navigationController?.popViewController(animated: false)
            self?.onDismiss?()
        }
    }
    
    @objc func playerDidFinishPlaying(_ notification: Notification) {
        let index = LevelAccessManager.alphabet.index(
            LevelAccessManager.alphabet.startIndex,
            offsetBy: currentLetter
        )
        levelLabel.text = String(LevelAccessManager.alphabet[index])
        if counterOfRepetitions < 1 {
            player.seek(to: CMTime.zero)
            player.play()
            counterOfRepetitions += 1
        } else {
            counterOfRepetitions = 0
            player.pause()
            nextButton.isHidden = false
        }
    }
    
    @objc func playerDidStartPlaying(_ notification: Notification) {
        let index = LevelAccessManager.alphabet.index(
            LevelAccessManager.alphabet.startIndex,
            offsetBy: currentLetter
        )
        levelLabel.text = String(LevelAccessManager.alphabet[index])
    }
}
