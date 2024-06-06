//
//  StagesViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/3/23.
//

import UIKit
import FirebaseAuth
import Combine

final class StagesViewController: UIViewController, 
                                UICollectionViewDataSource,
                                UICollectionViewDelegate,
                                UICollectionViewDelegateFlowLayout {
    
    private var viewModel = HomeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: UI
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: view.bounds.width - 20, height: 70)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AppColor.beige.uiColor
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StagesViewCell.self, forCellWithReuseIdentifier: StagesViewCell.identifier)
        collectionView.register(
            StagesHeaderSectionView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StagesHeaderSectionView.identifier
        )
        return collectionView
    }()
    
    private lazy var completionProgressView: CompletionProgressView = {
        let view = CompletionProgressView()
        view.layer.cornerRadius = 10
        return view
    }()

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        handleAuthentication()
        viewModel.retrieveUser()
        completionProgressView.changeProgress(by: Double(LevelAccessManager.currentLevel) * 0.0238)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        collectionView.dataSource = self
        collectionView.delegate = self
        setupViews()
        setupConstraints()
        bindViews()
        completionProgressView.changeProgress(by: Double(LevelAccessManager.currentLevel) * 0.0238)
    }

    // MARK: Constraints
    private func setupViews() {
        view.addSubview(completionProgressView)
        view.addSubview(collectionView)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupConstraints() {
        completionProgressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(completionProgressView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: Actions
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    private func completeUserOnboarding() {
        let vc = UINavigationController(rootViewController: ProfileDataFormViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
            }
            LevelAccessManager.learningScore = Int(user.learningScore) ?? 0
            LevelAccessManager.currentLevel = Int(user.learningProgress) ?? 0
            LevelAccessManager.shared.unlockLevelAccess()
            self?.reloadCells()
        }
        .store(in: &subscriptions)
    }
    
    func reloadCells() {
        collectionView.reloadData()
        completionProgressView.changeProgress(by: Double(LevelAccessManager.currentLevel) * 0.0238)
    }
    
    // MARK: Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 42
        case 1:
            return 42
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier:
                                                                                "StagesHeaderSectionView",
                                                                             for: indexPath)
                    as? StagesHeaderSectionView else {
                print("Unable to cast the dequeued view to StagesHeaderSectionView")
                return UICollectionReusableView()
            }
            headerView.configureLevelLabel(with: indexPath)
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 50)
    }
    
    // swiftlint: disable all
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        // Letters
        case 0:
            let letterQueue = indexPath.row
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StagesViewCell",
                                                          for: indexPath) as? StagesViewCell
                else {
                print("Unable to cast the dequeued cell to StagesViewCell")
                return UICollectionViewCell()
            }
            cell.configureButton(with: letterQueue)
            cell.onStageButtonTap = { [weak self] in
                let viewController = LetterController()
                viewController.tabBarController?.tabBar.isHidden = true
                viewController.currentLetter = letterQueue
                print(letterQueue)
                self?.navigationController?.pushViewController(viewController, animated: false)
                viewController.onDismiss = { [weak self] in
                    self?.reloadCells()
                }
            }
            return cell
            
        // Numbers
        case 1:
            let letterQueue = indexPath.row
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StagesViewCell",
                                                          for: indexPath) as? StagesViewCell
                else {
                print("Unable to cast the dequeued cell to StagesViewCell")
                return UICollectionViewCell()
            }
            cell.configureButton(with: 43 + letterQueue)
            cell.onStageButtonTap = { [weak self] in
                let viewController = NumberController()
                viewController.currentLetter = 43 + letterQueue
                self?.navigationController?.pushViewController(viewController, animated: false)
                viewController.onDismiss = { [weak self] in
                    self?.reloadCells()
                }
            }
            return cell
        default:
            let letterQueue = indexPath.row
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StagesViewCell",
                                                          for: indexPath) as? StagesViewCell
                else {
                print("Unable to cast the dequeued cell to StagesViewCell")
                return UICollectionViewCell()
            }
            cell.configureButton(with: letterQueue)
            cell.onStageButtonTap = { [weak self] in
                let viewController = LetterController()
                viewController.currentLetter = letterQueue
                self?.navigationController?.pushViewController(viewController, animated: false)
                viewController.onDismiss = { [weak self] in
                    self?.reloadCells()
                }
            }
            return cell
        }
    }
    
    // swiftlint: enable all
}
