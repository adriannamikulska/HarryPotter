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
        tableView.backgroundView = viewModel.backgroundView
        registerTable()
        getCharacters()
        setupButton()
    }
    
    //MARK: - Private
    private func getCharacters() {
        viewModel.downloadCharacters()
    }
    
    private func registerTable() {
        tableView.register(HouseMemberCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite characters", style: .plain, target: self, action: #selector(didTapFavorite))
    }
    
    @objc func didTapFavorite() {
        let viewModel = FavouriteViewModel()
        let favoriteVC = FavouriteViewController(favouriteViewModel: viewModel)
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name: "Cochin-Bold", size: 20)
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
    
    //    func favouriteCharacter(cell: UITableViewCell) {
    //        guard let indexPathTapped = tableView.indexPath(for: cell) else {return}
    //        let character = viewModel.characters[indexPathTapped.row]
    //        let name = character.name
    //        print(name)
    //    }
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
        cell.selectionStyle = .none
        cell.markedFavourite = {
            print(currentCharacter.name)
            if let encoded = try? JSONEncoder().encode(currentCharacter) {
                UserDefaults.standard.set(encoded, forKey: self.viewModel.userKey)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
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

