//
//  StagesHeaderSectionView.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/13/23.
//

import UIKit
import SnapKit

final class StagesHeaderSectionView: UICollectionReusableView {
    
    static let identifier = "StagesHeaderSectionView"
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Stages.letters", comment: "")
        label.textColor = AppColor.red.uiColor
        label.font = AppFont.bold.s24()
        return label
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
        self.layer.cornerRadius = 16
        self.backgroundColor = .clear
        self.addSubview(levelLabel)
    }
    
    private func setupConstraints() {
        levelLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.leading.equalTo(self).offset(30)
        }
    }
    
    // MARK: Actions
    override func prepareForReuse() {
        super.prepareForReuse()
        levelLabel.text = ""
    }
    
    public func configureLevelLabel(with letter: IndexPath) {
        switch letter.section {
        case 0:
            levelLabel.text = NSLocalizedString("Stages.letters", comment: "")
        case 1:
            levelLabel.text = NSLocalizedString("Stages.numbers", comment: "")
        case 2:
            levelLabel.text = NSLocalizedString("Stages.meAndYou", comment: "")
        case 3:
            levelLabel.text = NSLocalizedString("Stages.Human&Family", comment: "")
        case 4:
            levelLabel.text = NSLocalizedString("Stages.Home", comment: "")
        default:
            levelLabel.text = "s"
        }
    }
}
