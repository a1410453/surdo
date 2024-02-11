//
//  QuizViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 12/7/23.
//

import UIKit
import SnapKit
import PanModal
import SDWebImage

final class QuizViewController: UIViewController {
    // MARK: - Variables
    var currentQuestion: Int = 1
    var currentLetter: Int = LevelAccessManager.currentLevel + 1
    var rightAnswer: Int = Int.random(in: 0..<4)
    var falseAnswers = Set<Int>()
    
    var onDismiss: (() -> Void)?
    
    // MARK: - UI
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.red.uiColor
        label.text = "Выберите правильный ответ:"
        label.font = AppFont.bold.s18()
       
        return label
    }()
    
    lazy var questionIndicatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.red.uiColor
        label.text = "\(currentQuestion)/5"
        label.font = AppFont.bold.s18()
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
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.red.uiColor
        button.tintColor = AppColor.beige.uiColor
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = AppFont.medium.s24()
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        falseAnswers = generateUniqueRandomNumbers()
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
        navigationController?.navigationBar.isHidden = false
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
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }
    
    // MARK: Action
    @objc func tappedNextButton() {
        if currentQuestion < 5 {
            currentQuestion += 1
            questionIndicatorLabel.text = "\(currentQuestion)/5"
            nextButton.isHidden = true
            rightAnswer = Int.random(in: 0..<4)
            falseAnswers = generateUniqueRandomNumbers()
            refreshQuestions()
        } else {
            let controller = FinishedViewController()
            self.presentPanModal(controller)
            controller.onDismiss = { [weak self] in
                self?.navigationController?.popViewController(animated: false)
                self?.onDismiss?()
            }
        }
    }
    
    func refreshQuestions() {
        collectionView.reloadData()
    }
    
    func passCurrentLetter(_ letter: Int) {
        currentLetter = letter + 1
    }
    
    func generateUniqueRandomNumbers() -> Set<Int> {
        var uniqueNumbers = Set<Int>()
        uniqueNumbers.insert(currentLetter)
        while uniqueNumbers.count < 4 {
            let randomNumber = Int.random(in: 0...42)
            uniqueNumbers.insert(randomNumber)
        }
        uniqueNumbers.remove(currentLetter)
        return uniqueNumbers
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizQuestionCell.identifier,
                                                      for: indexPath) as? QuizQuestionCell else {
        return UICollectionViewCell()
    }
        if indexPath.item == rightAnswer {
            cell.setImageForQuiz(url: AppConstants.makePictureURL(middlePart: currentLetter))
        } else {
            let falseAnswer = falseAnswers.removeFirst()
            cell.setImageForQuiz(url: AppConstants.makePictureURL(middlePart: falseAnswer))
        }
        cell.didNotPressedAnswer()
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
        if indexPath.item == rightAnswer {
            cell.didPressedRightAnswer()
            LevelAccessManager.learningScore += 10
            nextButton.isHidden = false
        } else {
            cell.didPressedWrongAnswer()
        }
    }
}
