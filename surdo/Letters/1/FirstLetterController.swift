//
//  FirstLetterController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//

import UIKit

class FirstLetterController: UIViewController {
    
    private lazy var gestureView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = AppImage.gesture.uiImage
        iconView.contentMode = .center
        return iconView
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "ӘРІПТЕР"
        label.textColor = .blue
        label.font = AppFont.bold.s24()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(gestureView)
        view.addSubview(levelLabel)
    }

    private func setupConstraints() {
        gestureView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(200)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
    }
}
