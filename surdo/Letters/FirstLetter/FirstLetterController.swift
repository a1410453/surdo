//
//  FirstLetterController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//

import UIKit

class FirstLetterController: UIViewController {
    
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
        label.font = AppFont.bold.s36()
        return label
    }()
    
    private lazy var levelDescription: UILabel = {
        let label = UILabel()
        label.text = "Бұл А әрпі. \nҚолды жұдырыққа қысыңыз және көрсетіңіз\n\n\n Это буква А. \nЗажмите руку в кулак и покажите"
        label.textColor = AppColor.red.uiColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = AppFont.semibold.s16()
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.next.systemImage, for: .normal)
        button.tintColor = AppColor.red.uiColor
        button.imageView?.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(gestureView)
        view.addSubview(levelLabel)
        view.addSubview(levelDescription)
        view.addSubview(nextButton)
    }

    private func setupConstraints() {
        gestureView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(gestureView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        levelDescription.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(levelDescription.snp.bottom).offset(150)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nextButton.imageView?.snp.makeConstraints{ make in
            make.size.equalTo(80)
        }
    }
    
    // MARK: Action
    @objc func tappedNextButton() {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}
