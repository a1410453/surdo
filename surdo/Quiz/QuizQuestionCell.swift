//
//  QuizQuestionCell.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/7/23.
//

import UIKit

final class QuizQuestionCell: UICollectionViewCell {
    
    static let identifier = "QuizQuestionCell"
    
    private lazy var signImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.gesture.uiImage
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = AppColor.beige.cgColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        addSubview(signImage)
        configureConstraints()
    }
    
    private func configureConstraints() {
        signImage.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(13)
            make.size.equalTo(180)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didPressedRightAnswer() {
        signImage.layer.borderColor = CGColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    
    func didPressedWrongAnswer() {
        signImage.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
}
