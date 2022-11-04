//
//  FavouriteViewController.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 28/09/2022.
//

import UIKit

final class FavouriteViewController: UITableViewController {
    
    //MARK: - Properties
    
    private let cellId = "cellId"
    private var favouriteViewModel: FavouriteViewModelProtocol
    private lazy var characters =  favouriteViewModel.characters {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    init(favouriteViewModel: FavouriteViewModelProtocol) {
        self.favouriteViewModel = favouriteViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableRegister()
        tableView.backgroundView = favouriteViewModel.backgroundView
//        if let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.jobCategory.rawValue) as? Data,
//           let category = try? JSONDecoder().decode(JobCategory.self, from: data) {
//             print(category.name)
//        }
        if let favouriteCharacter = UserDefaults.standard.object(forKey: favouriteViewModel.userKey) as? Data, // as [Characters]
        let category = try? JSONDecoder().decode(Character.self, from: favouriteCharacter) {
            print(category.name)
        }
    }
    
    //MARK: - Private
    
    private func tableRegister() {
        tableView.register(FavouriteMemberCell.self, forCellReuseIdentifier: cellId)
    }

    private lazy var header: UILabel = {
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.textAlignment = .center
        header.font = UIFont(name: "Cochin-Bold", size: 20)
        header.text = "Favorite characters"
        header.textColor = .white
        
        return header
    }()
}

extension FavouriteViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FavouriteMemberCell
        cell.backgroundColor = favouriteViewModel.backgroundColor
        let currentCharacter = characters[indexPath.row]
        cell.memberLabel.text = currentCharacter.name //favouriteViewModel.character.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
}
