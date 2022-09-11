//
//  HouseViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 24/08/2022.
//

import UIKit

struct Character: Decodable {
    let name: String
    let house: String
    let species: String
    let ancestry: String
    let patronus: String
    let alive: Bool
    let image: String
}

enum HouseOfHogwart: Int {
    case gryffindor = 0
    case slytherin = 1
    case ravenclaw = 2
    case hufflepuff = 3
    
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
    var backgroundColor: UIColor { get }
    var headerText: String {get}
    var textColor: UIColor {get}
    var numberOfLine: Int {get}
    var delegate: HouseViewModelDelegate? { get set }
    
    func downloadCharacters()
}

final class HouseViewModel: HouseViewModelProtocol {

    private let house: HouseOfHogwart
    weak var delegate: HouseViewModelDelegate?
    private let apiClient = APIClient()
    
    init(house: HouseOfHogwart) {
        self.house = house
    }
    
    // MARK: - HouseViewModelProtocol
    
    var characters = [Character]()
    let backgroundColor = UIColor(red: 0, green: 28, blue: 41)
    let headerText = "Members of house"
    let textColor = UIColor.white
    let numberOfLine  = 0
    
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
