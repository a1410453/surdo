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
        view.backgroundColor = .white
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
        self.addSubview(containerView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        completedPartView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(60)
        }
        
        uncompletedPartView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(completedPartView.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func changeProgress(by width: Int) {
        completedPartView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(width)
        }
    }
}
