//
//  CharacterViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 10/09/2022.
//

import UIKit

protocol CharacterViewModelProtocol {
    var backgroundColor: UIColor { get }
    var character: Character { get }
    var backgroundView: UIImageView { get}
}

final class CharacterViewModel: CharacterViewModelProtocol {
    var character: Character
    var backgroundView = UIImageView(image: UIImage(named: "tlo-kopia"))
    let backgroundColor = UIColor(red: 0, green: 28, blue: 41)
    private let apiClient = APIClient()
    
    
    init(character: Character) {
        self.character = character
    }

}
