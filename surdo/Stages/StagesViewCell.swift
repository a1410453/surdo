//
//  StagesViewCell.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/3/23.
//

import UIKit
import SnapKit

final class StagesViewCell: UICollectionViewCell {
    
    static let identifier = "StagesViewCell"
    
    var onStageButtonTap: (() -> Void)?
    
    private lazy var stageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "disabled"), for: .disabled)
        button.imageView?.layer.masksToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
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
    
    // MARK: Actions
    public func configureButton(with letter: Int) {
        stageButton.setImage(UIImage(named: String(letter)), for: .normal)
        stageButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        if !(LevelAccessManager.shared.checkLevelAccess(level: letter)) {
            stageButton.isEnabled = false
        } else {
            stageButton.isEnabled = true
        }
        
        stageButton.snp.remakeConstraints { [letter] make in
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(103)
            make.height.equalTo(70)
            var offset: CGFloat {
                switch letter % 8 {
                case 1, 3: return 65
                case 2: return 85
                case 5, 7: return -65
                case 6: return -85
                default: return 0
                }
            }
            make.centerX.equalToSuperview().offset(offset)
        }
    }
    
    @objc func tappedButton() {
        self.onStageButtonTap?()
    }
}
