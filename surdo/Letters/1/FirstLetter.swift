//
//  FirstLetter.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/9/23.
//

import UIKit

class FirstLetter: UIViewController {

    private lazy var gestureView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = AppImage.gesture.uiImage
        iconView.contentMode = .center
        return iconView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(gestureView)
    }

    private func setupConstraints() {
        
    }
}
