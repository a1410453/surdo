//
//  StagesViewCell.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/3/23.
//

import UIKit
import SnapKit

class StagesViewCell: UICollectionViewCell {
    
    static let identifier = "StagesViewCell"
    
    private let stageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "A"), for: .disabled)
        return button
    }()

    let levelManager = LevelAccessManager.shared

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .clear
        contentView.addSubview(stageButton)
    }
    
    private func setupConstraints() {
        stageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(205)
            make.height.equalTo(140)
        }
    }
    
    //MARK: Actions
    public func configureButton(with letter: Int){
        if letter == -1 {
            stageButton.setImage(UIImage(), for: .normal)
        } else {
            stageButton.setImage(UIImage(named: String(letter-1)), for: .normal)
            if !(levelManager.checkLevelAccess(level: letter-1)) {
                stageButton.isEnabled = false
            }
        }
    }
}
