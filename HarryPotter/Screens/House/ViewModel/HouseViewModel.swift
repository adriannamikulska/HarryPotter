//
//  HouseViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 24/08/2022.
//

import UIKit

struct Character {
    let name: String
    let house: String
    let species: String
    let ancestry: String
    let patronus: String
    let alive: Bool
}

protocol HouseViewModelDelegate {
    func refreshView()
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
    
    private let house: House
    var delegate: HouseViewModelDelegate?
    
    init(house: House) {
        self.house = house
    }
    
    // MARK: - HouseViewModelProtocol
    
    var characters = [Character]()
    let backgroundColor = UIColor(red: 0, green: 28, blue: 41)
    let headerText = "Members of house"
    let textColor = UIColor.white
    let numberOfLine  = 0
    
    func downloadCharacters() {
        // TODO: - Get characters from API Client
        characters = [
            Character(name: "Harry",
                      house: "Gryffindor",
                      species: "Human",
                      ancestry: "yy",
                      patronus: "yy",
                      alive: true),
            Character(name: "Hermiona",
                      house: "Gryfindor",
                      species: "Human",
                      ancestry: "xx",
                      patronus: "xx",
                      alive: true),
        ]
        
        delegate?.refreshView()
    }
}
