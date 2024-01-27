//
//  DownloadErrorView.swift
//  surdo
//
//  Created by Rustem Orazbayev on 1/27/24.
//
import UIKit
import SnapKit

final class DownloadErrorView: UIView {
    // MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.errorIcon.uiImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = AppFont.bold.s18()
        title.textColor = .black
        title.text = "Ошибка загрузки"
        title.textAlignment = .center
        return title
    }()

    private lazy var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = AppFont.regular.s14()
        subtitle.textColor = .black
        subtitle.text = """
       Сообщение не загрузилось. Это может произойти из за плохой связи или
       из за отсутствия интернет подключения.
       """
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        return subtitle
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = AppColor.beige.uiColor

        [title,
         subtitle].forEach { stackView.addArrangedSubview($0) }

        [imageView,
         stackView].forEach { addSubview($0) }
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(230)
            make.leading.equalToSuperview().offset(155)
            make.size.equalTo(80)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(36)
            make.trailing.equalToSuperview().offset(-36)
        }
    }
}
