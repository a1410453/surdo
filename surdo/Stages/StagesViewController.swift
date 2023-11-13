//
//  StagesViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/3/23.
//

import UIKit

class StagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 100
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        collectionView.dataSource = self
        collectionView.delegate = self
        setupViews()
        setupConstraints()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 46
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StagesHeaderSectionView", for: indexPath) as! StagesHeaderSectionView
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let letterQueue = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StagesViewCell", for: indexPath) as! StagesViewCell
        cell.configureButton(with: letterQueue)
        cell.onStageButtonTap = { [weak self] in
            let viewController = FirstLetterController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        return cell
        
    }
    
    
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
}
