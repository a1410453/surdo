//
//  StagesViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/3/23.
//

import UIKit

class StagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "ӘРІПТЕР"
        label.textColor = AppColor.red.uiColor
        label.font = AppFont.bold.s24()
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 100
        layout.itemSize = CGSize(width: view.bounds.width - 20, height: 70)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AppColor.beige.uiColor
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StagesViewCell.self, forCellWithReuseIdentifier: StagesViewCell.identifier)
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.beige.uiColor
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(StagesViewCell.self, forCellWithReuseIdentifier: "StagesViewCell")
        setupViews()
        setupConstraints()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 46
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let letterQueue = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StagesViewCell", for: indexPath) as! StagesViewCell
        cell.configureButton(with: letterQueue)
        
        return cell

    }
    

    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(levelLabel)
    }
    
    private func setupConstraints() {
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}
