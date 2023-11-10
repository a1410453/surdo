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
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "A"), for: .disabled)
        button.backgroundColor = .clear
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
            make.width.equalTo(103)
            make.height.equalTo(70)
        }
    }
    
    //MARK: Actions
    public func configureButton(with letter: Int){
        print(letter)
        stageButton.setImage(UIImage(named: String(letter)), for: .normal)
        stageButton.imageView?.layer.masksToBounds = true
        stageButton.imageView?.contentMode = .scaleAspectFit
        stageButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        if !(levelManager.checkLevelAccess(level: letter)) {
            stageButton.isEnabled = false
        } else {
            stageButton.isEnabled = true
        }
        if letter % 4 == 0 {
            stageButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(5)
                make.leading.equalToSuperview().offset(15)
                make.width.equalTo(103)
                make.height.equalTo(70)
            }
        } else if  letter % 4 == 2 {
            stageButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(5)
                make.trailing.equalToSuperview().offset(-15)
                make.width.equalTo(103)
                make.height.equalTo(70)
            }
        } else {
            stageButton.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(5)
                make.centerX.equalToSuperview()
                make.width.equalTo(103)
                make.height.equalTo(70)
            }
        }
    }
    
    @objc func tappedButton() {
        
    }
}
