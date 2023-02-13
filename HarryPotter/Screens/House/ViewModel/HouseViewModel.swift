//
//  HouseViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 24/08/2022.
//

import UIKit

struct Character: Codable, Hashable, CharacterProtocol {
    let name: String
    let house: String
    let species: String
    let ancestry: String
    let patronus: String
    let alive: Bool
    let image: String
    let id: String
}

extension CharacterDB: CharacterProtocol {}

extension House {
    var apiName: String {
        switch self {
        case .gryffindor: return "gryffindor"
        case .slytherin: return "slytherin"
        case .ravenclaw: return "ravenclaw"
        case .hufflepuff: return "hufflepuff"
        }
    }
}

protocol HouseViewModelDelegate: AnyObject {
    func didUpdateCharacters()
    func didFailWithError(error: Error)
}

protocol HouseViewModelProtocol {
    var characters: [Character] { get }
    var backgroundView: UIImageView { get }
    var backgroundColor: UIColor { get }
    var delegate: HouseViewModelDelegate? { get set }
    var dependencies: ApplicationDependencies { get }
    var cellId: String { get }
    var headerId: String { get }
    
    func downloadCharacters()
}

final class HouseViewModel: HouseViewModelProtocol {
    private let house: House
    weak var delegate: HouseViewModelDelegate?
    private let apiClient: APIClient
    let dependencies: ApplicationDependencies
    
    init(house: House, apiClient: APIClient, dependencies: ApplicationDependencies) {
        self.house = house
        self.apiClient = apiClient
        self.dependencies = dependencies
    }
    
    // MARK: - HouseViewModelProtocol
    
    var characters = [Character]()
    let backgroundView = UIImageView(image: UIImage(named: "tlo-kopia"))
    let backgroundColor = UIColor(red: 0, green: 28, blue: 41)
    let cellId = "cellId"
    let headerId = "headerId"
    
    func downloadCharacters() {
        apiClient.downloadHogwartCharacters(for: house, onComplete: { [weak self] (characters, error) in
            if let error = error {
                self?.delegate?.didFailWithError(error: error)
            } else {
                self?.characters = characters
                self?.delegate?.didUpdateCharacters()
            }
        })
    }
}


