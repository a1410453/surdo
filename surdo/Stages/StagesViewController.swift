//
//  StagesViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/3/23.
//

import UIKit
import FirebaseAuth
import Combine

class StagesViewController: UIViewController, 
                                UICollectionViewDataSource,
                                UICollectionViewDelegate,
                                UICollectionViewDelegateFlowLayout {
    
    private var viewModel = HomeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: UI
    private lazy var collectionView: UICollectionView = {
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
    
    // MARK: lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retrieveUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        collectionView.dataSource = self
        collectionView.delegate = self
        setupViews()
        setupConstraints()
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    // MARK: Constraints
    private func setupViews() {
        view.addSubview(collectionView)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 46
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
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            self?.navigationController?.pushViewController(viewController, animated: false)
        }
        return cell
        
    }
}
