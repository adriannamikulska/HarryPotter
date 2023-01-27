//
//  HouseViewController.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 24/08/2022.
//

import UIKit
import CoreData

final class HouseViewController: UITableViewController {
    
    //MARK: - Properties
    
    private var houseViewModel: HouseViewModelProtocol

    //MARK: - Lifecycle
    
    init(viewModel: HouseViewModelProtocol) {
        self.houseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        houseViewModel.delegate = self
        tableView.backgroundView = houseViewModel.backgroundView
        registerTable()
        getCharacters()
        setupButton()
    }
    
    //MARK: - Private
    private func getCharacters() {
        houseViewModel.downloadCharacters()
    }
    
    private func registerTable() {
        tableView.register(HouseMemberCell.self, forCellReuseIdentifier: houseViewModel.cellId)
    }
    
    private func setupButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite characters", style: .plain, target: self, action: #selector(didTapFavorite))
    }
    
    @objc func didTapFavorite() {
        let viewModel = FavouriteViewModel(dependencies: self.houseViewModel.dependencies)
        let favoriteVC = FavouriteViewController(favouriteViewModel: viewModel)
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name: "Cochin-Bold", size: 20)
        headerLabel.backgroundColor = houseViewModel.backgroundColor
        headerLabel.textColor = houseViewModel.textColor
        headerLabel.numberOfLines = houseViewModel.numberOfLine
        headerLabel.text = houseViewModel.headerText
        headerLabel.textAlignment = .center
        return headerLabel
    }()
}

extension HouseViewController: HouseViewModelDelegate {
    
    func didUpdateCharacters() {
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension HouseViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseViewModel.characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: houseViewModel.cellId, for: indexPath) as! HouseMemberCell
        let currentCharacter = houseViewModel.characters[indexPath.row]
        cell.myLabel.text = currentCharacter.name
        cell.backgroundColor = houseViewModel.backgroundColor
        cell.selectionStyle = .none
    
        let person = houseViewModel.characters[indexPath.row]
        cell.setPersonLabel(text: person.name.capitalized)
        let isAlreadyFavourite = houseViewModel.dependencies.dataController.isSaved(person: person)
        cell.setButtonState(isSelected: isAlreadyFavourite)
        cell.markedFavourite = { [weak self] shouldDelete in
            do {
                if shouldDelete {
                    try self?.houseViewModel.dependencies.dataController.delete(person: person)
                } else {
                    try self?.houseViewModel.dependencies.dataController.insert(person: person)
                }
            } catch(let error) {
                print(error)
            }
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = houseViewModel.characters[indexPath.row]
        let characterViewModel = CharacterViewModel(character: character)
        let characterVC = CharacterViewController(characterViewModel: characterViewModel)
        self.navigationController?.pushViewController(characterVC, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerLabel
    }
}

