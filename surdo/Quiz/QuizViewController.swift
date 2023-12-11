//
//  QuizViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/7/23.
//

import UIKit
import SnapKit

final class QuizViewController: UIViewController {
    
    // MARK: - UI
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.red.uiColor
        label.text = "Сұрақ:"
        label.font = AppFont.bold.s24()
       
        return label
    }()
    
    private lazy var questionIndicatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.red.uiColor
        label.text = "1/5"
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(QuizQuestionCell.self,
                                forCellWithReuseIdentifier: QuizQuestionCell.identifier)
        collectionView.backgroundColor = AppColor.beige.uiColor
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.next.systemImage, for: .normal)
        button.tintColor = AppColor.red.uiColor
        button.imageView?.layer.masksToBounds = false
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        setupViews()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.addSubview(questionLabel)
        view.addSubview(questionIndicatorLabel)
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        nextButton.isHidden = true
        nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupLayout() {
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
        }
        
        questionIndicatorLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel).offset(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-300)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
    }
    
    // MARK: Action
    @objc func tappedNextButton() {
        
    }
}

extension QuizViewController: UICollectionViewDataSource, 
                                UICollectionViewDelegate,
                                UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizQuestionCell.identifier,
                                                      for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 5
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? QuizQuestionCell else {
            return
        }
        if indexPath.item == 1 {
            cell.didPressedRightAnswer()
            nextButton.isHidden = false
        } else {
            cell.didPressedWrongAnswer()
        }
    }
}
