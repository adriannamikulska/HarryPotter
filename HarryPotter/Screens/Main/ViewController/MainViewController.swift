//
//  MainViewController.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 18/08/2022.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let viewModel: MainViewModel
    private let cellId = "cellId"
    private let headerId = "headerId"
    private static let categoryHeaderId = "categoryHeaderId"
    
    // MARK: - Lifecycle
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: MainViewController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        registerCells()
    }
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        navigationItem.title = viewModel.screenTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        navigationItem.backButtonTitle = viewModel.backTitle
    }
    
    private func registerCells() {
        collectionView.register(MainHouseCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MainCollectionHeaderView.self, forSupplementaryViewOfKind: MainViewController.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
}

extension MainViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10 // TODO: Check count of characters array
        case 1:
            return 4
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            // TODO: Add new type for section 0 cells
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MainHouseCell else { return UICollectionViewCell() }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MainHouseCell else { return UICollectionViewCell() }
            cell.backgroundColor = .none
            
            let currentHouse = MainViewModel.House(rawValue: indexPath.item)
            cell.myImageView.image = currentHouse?.image
            cell.myLabel.text = currentHouse?.name
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: If sections is 1 navigate to TableView
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
}

extension MainViewController {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) ->
            NSCollectionLayoutSection? in
            
            if section == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 5
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                group.contentInsets.leading = 16
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .top)]
                   
                return section
            }
        }
    }
}
