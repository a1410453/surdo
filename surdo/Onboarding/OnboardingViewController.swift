//
//  OnboardingViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/14/23.
//

import UIKit

class OnboardingViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Start learning Kazakh Sign Language today"
        label.font = AppFont.bold.s32()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = AppFont.bold.s24()
        button.backgroundColor = AppColor.red.uiColor
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.layer.cornerRadius = 30
        return button
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Have an account already?"
        label.tintColor = .gray
        label.font = AppFont.regular.s24()
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.tintColor = AppColor.red.uiColor
        
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        configureConstraints()
    }
    
    @objc private func didTapCreateAccount() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLogin() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureConstraints() {
        let welcomeLabelConstraints = [
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let createAccountButtonConstraints = [
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccountButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let promptLabelConstraints = [
        
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        let loginButtonConstraints = [
            loginButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        NSLayoutConstraint.activate(createAccountButtonConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
    }
}
