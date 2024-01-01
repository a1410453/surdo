//
//  FinishedQuizController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/28/23.
//

import UIKit
import SnapKit
import PanModal

final class FinishedViewController: UIViewController {

    // MARK: - UI
    private lazy var exclamationMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.gesture.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var sureCancelOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы прошли этот урок"
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.red.uiColor
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    private lazy var blockInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Поздравляю вы можете перейти к следующему уровню. Продолжайте в том же духе!"
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.red.uiColor
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = AppColor.red.uiColor
        button.setTitleColor(AppColor.beige.uiColor, for: .normal)
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(didPressedConfirmButton), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.tabbar.uiColor

        [exclamationMarkImageView, 
         sureCancelOrderLabel,
         blockInfoLabel,
         confirmButton].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        exclamationMarkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }

        sureCancelOrderLabel.snp.makeConstraints { make in
            make.top.equalTo(exclamationMarkImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        blockInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(sureCancelOrderLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(blockInfoLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(51)
        }
    }

    // MARK: - Actions
    @objc private func didPressedConfirmButton() {
        
    }
}

// MARK: - Pan Presentation

extension FinishedViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(398)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(40)
    }
}
