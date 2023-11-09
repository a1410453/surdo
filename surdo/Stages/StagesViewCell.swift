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
            make.centerX.equalToSuperview()
            make.width.equalTo(205)
            make.height.equalTo(140)
        }
    }
    
    
    //MARK: Actions
    public func configureButton(with letter: Int){
        print(letter)
        stageButton.setImage(UIImage(named: String(letter)), for: .normal)
        if !(levelManager.checkLevelAccess(level: letter)) {
            stageButton.isEnabled = false
        }
        if letter % 2 == 0 {
            stageButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(40)
                make.leading.equalToSuperview().offset(20)
                make.width.equalTo(205)
                make.height.equalTo(140)
            }
        } else {
            stageButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(40)
                make.leading.equalToSuperview().offset(-140)
                make.width.equalTo(205)
                make.height.equalTo(140)
            }
        }
        
    }
}
