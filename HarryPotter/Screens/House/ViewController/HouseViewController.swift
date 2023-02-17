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
        registerHeader()
        getCharacters()
    }
    
    //MARK: - Private
    private func getCharacters() {
        houseViewModel.downloadCharacters()
    }
    
    private func registerTable() {
        tableView.register(HouseMemberCell.self, forCellReuseIdentifier: houseViewModel.cellId)
    }
    
    private func registerHeader() {
        tableView.register(HouseHeader.self, forHeaderFooterViewReuseIdentifier: houseViewModel.headerId)
    }
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
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: houseViewModel.headerId) as! HouseHeader
        return headerView
    }
}

