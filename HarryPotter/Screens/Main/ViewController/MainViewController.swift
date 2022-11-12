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
    private let apiClient = APIClient()
    
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
        backgroundView()
    }
    
    // MARK: - Private
    
    private func backgroundView() {
        collectionView.backgroundView = viewModel.backgroundView
    }
    
    private func setupNavigationBar() {
        navigationItem.title = viewModel.screenTitle
        navigationItem.backButtonTitle = viewModel.backTitle
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, .font: UIFont(name: "Cochin-Bold", size: 25)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
            return 10 
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
            let currentIndex = MainViewModel.Images(rawValue: indexPath.item)
            cell.myImageView.image = currentIndex?.nameImage
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MainHouseCell else { return UICollectionViewCell() }
            cell.backgroundColor = .none
            
            let currentHouse = House(rawValue: indexPath.item)
            cell.myImageView.image = currentHouse?.image
            cell.myLabel.text = currentHouse?.name
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let houseViewModel = HouseViewModel(house: House(rawValue: indexPath.item)!, apiClient: apiClient)
            let houseViewController = HouseViewController(viewModel: houseViewModel)
            navigationController?.pushViewController(houseViewController, animated: true)
        }
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
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(210)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 5
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                group.contentInsets.leading = 16
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .top)]
                   
                return section
            }
        }
    }
}
