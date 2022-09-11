//
//  CharacterViewController.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 10/09/2022.
//

import UIKit

class CharacterViewController: UICollectionViewController {
    
    //MARK: - Properties
    private let characterCellId = "characterCellId"
    private let  characterViewModel: CharacterViewModelProtocol
    
    
    //MARK: - Lifecycle
    init(characterViewModel: CharacterViewModelProtocol) {
        self.characterViewModel = characterViewModel
        super.init(collectionViewLayout: CharacterViewController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.backgroundColor = characterViewModel.backgroundColor
        collectionView.backgroundView = characterViewModel.backgroundView
        characterRegister()
    }
    
    //MARK: - Private
    
    private func characterRegister() {
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: characterCellId)
    }
    
}

extension CharacterViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCellId, for: indexPath) as? CharacterCell else {return UICollectionViewCell()}
            cell.backgroundColor = .none
            let urlString = characterViewModel.character.image
            guard let url = URL(string: urlString) else {
                return cell
            }
                let getDataTask = URLSession.shared.dataTask(with: url) { data, _, error  in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    cell.characterImage.image = image
                }
            }
            getDataTask.resume()
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCellId, for: indexPath) as? CharacterCell else {return UICollectionViewCell()}
            cell.backgroundColor = characterViewModel.backgroundColor
            if indexPath.item == 0 {
                cell.characterLabel.text = "Name: \(characterViewModel.character.name)"
            } else if indexPath.item == 1 {
                cell.characterLabel.text = "Spacies: \(characterViewModel.character.species)"
            } else if indexPath.item == 2 {
                cell.characterLabel.text = "Ancestry: \(characterViewModel.character.ancestry)"
            } else if indexPath.item == 3 {
                cell.characterLabel.text = "Patronus: \(characterViewModel.character.patronus)"
            } else  {
                cell.characterLabel.text = "Alive: \(characterViewModel.character.alive)"
            }
 
            return cell
        }
        return UICollectionViewCell()
    }
}
extension CharacterViewController {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) ->
            NSCollectionLayoutSection? in
            
            if section == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets.leading = 16
                item.contentInsets.trailing = 16
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 20
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)))
                item.contentInsets.trailing = 16
                item.contentInsets.leading = 16
                item.contentInsets.bottom = 5
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 10
                
                return section
            }
        }
    }
}

