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
    
    var onDismiss: (() -> Void)?
    
    // MARK: UI components
    private lazy var gestureView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = AppImage.gesture.uiImage
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.textColor = AppColor.red.uiColor
        label.font = AppFont.bold.s37()
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.red.uiColor
        button.tintColor = AppColor.beige.uiColor
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = AppFont.medium.s24()
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let containerView = UIView()
    private var player = AVPlayer(url: AppConstants.makeURL(middlePart: LevelAccessManager.currentLevel+1))
    private var playerLayer: AVPlayerLayer!
    
// swiftlint: disable all
    var counterOfRepetitions = 0
   
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupVideo()
        
    }
// swiftlint: enable all
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(levelLabel)
        view.addSubview(nextButton)
        view.addSubview(containerView)
        // for testing purposes:
        nextButton.isHidden = false
        //
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
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(80)
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
        player.play()
    }
    
    // MARK: Action
    @objc func tappedNextButton() {
        self.tabBarController?.tabBar.isHidden = false
        let viewController = QuizViewController()
        navigationController?.pushViewController(viewController, animated: true)
        viewController.onDismiss = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.onDismiss?()
        }
    }
    
    @objc func playerDidFinishPlaying(_ notification: Notification) {
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
    
}
