//
//  StagesViewController.swift
//  surdo
//
//  Created by Rustem Orazbayev on 11/3/23.
//

import UIKit

class StagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StagesViewCell.self, forCellWithReuseIdentifier: StagesViewCell.identifier)
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 150
        layout.minimumInteritemSpacing = 100
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Register your custom cell class
        collectionView.register(StagesViewCell.self, forCellWithReuseIdentifier: "CustomCellReuseIdentifier")
        
        // Add the collection view to the view controller's view
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    // Implement UICollectionViewDataSource methods to define the number of items and cell content
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 88
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let letterQueue = indexPath.row
       
        if letterQueue % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellReuseIdentifier", for: indexPath) as! StagesViewCell
            cell.configureButton(with: letterQueue/2)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellReuseIdentifier", for: indexPath) as! StagesViewCell
            cell.configureButton(with: -1)
            return cell
            
        }
       

    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}
