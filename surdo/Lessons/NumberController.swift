//
//  NumberController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 6/4/24.
//

import UIKit

final class NumberController: UIViewController {
    
    var number = " "
    var currentLetter = 0
    var onDismiss: (() -> Void)?
    
    // MARK: UI components
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "\(LevelAccessManager.numbers[currentLetter-43])"
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

    private lazy var signImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.logo.uiImage
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        return imageView
    }()
    
    var counterOfRepetitions = 0
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.setImageForNumber(url: AppConstants.makePictureURL(middlePart: currentLetter))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        self.setImageForNumber(url: AppConstants.makePictureURL(middlePart: currentLetter))
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(levelLabel)
        view.addSubview(nextButton)
        view.addSubview(signImage)
        // for testing purposes:
        nextButton.isHidden = false
        //
    }

    private func setupConstraints() {
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        signImage.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(400)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    
    // MARK: Action
    @objc func tappedNextButton() {
        let viewController = QuizViewController()
        viewController.passCurrentLetter(currentLetter-1)
        navigationController?.pushViewController(viewController, animated: true)
        viewController.onDismiss = { [weak self] in
            self?.tabBarController?.tabBar.isHidden = false
            self?.navigationController?.popViewController(animated: false)
            self?.onDismiss?()
        }
    }
    
    func setImageForNumber(url: URL) {
        self.signImage.sd_setImage(with: url)
    }
}
