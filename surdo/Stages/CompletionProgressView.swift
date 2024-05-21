//
//  CompletionProgressView.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/26/23.
//

import UIKit

final class CompletionProgressView: UIView {
    
    // MARK: UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.beige.uiColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var completedPartView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.red.uiColor
        return view
    }()
    
    private lazy var uncompletedPartView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray.uiColor
        return view
    }()
    
    private lazy var progressLabelView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = NSLocalizedString("Stages.progress", comment: "")
        label.font = AppFont.medium.s18()
        label.textAlignment = .center
        label.textColor = AppColor.tabbar.uiColor
        return label
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        containerView.addSubview(completedPartView)
        containerView.addSubview(uncompletedPartView)
        containerView.addSubview(progressLabelView)
        self.addSubview(containerView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        completedPartView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(60)
        }
        
        uncompletedPartView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(completedPartView.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
        progressLabelView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func changeProgress(by width: Double) {
        completedPartView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(width)
        }
    }
}
