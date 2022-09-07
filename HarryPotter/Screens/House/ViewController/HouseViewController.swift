//
//  HouseViewController.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 24/08/2022.
//

import UIKit

final class HouseViewController: UITableViewController {
    
    //MARK: - Properties
    
    private var viewModel: HouseViewModelProtocol
    private let cellId = "cellId"
    
    //MARK: - Lifecycle
    
    init(viewModel: HouseViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = viewModel.backgroundColor
        registerTable()
        getCharacters()
    }
    
    //MARK: - Private
    private func getCharacters() {
        viewModel.downloadCharacters()
    }
    
    private func registerTable() {
        tableView.register(HouseMemberCell.self, forCellReuseIdentifier: cellId)
    }
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name: "Cochin-Bold", size: 25)
        headerLabel.backgroundColor = viewModel.backgroundColor
        headerLabel.textColor = viewModel.textColor
        headerLabel.numberOfLines = viewModel.numberOfLine
        headerLabel.text = viewModel.headerText
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
        return viewModel.characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HouseMemberCell
        let currentCharacter = viewModel.characters[indexPath.row]
        cell.myLabel.text = currentCharacter.name
        cell.backgroundColor = viewModel.backgroundColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Navigate to CharacterViewController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerLabel
    }
}
