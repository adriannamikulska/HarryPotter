//
//  FavouriteViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 28/09/2022.
//

import UIKit

protocol FavouriteViewModelProtocol {
    var dependencies: HasDataController { get }
    var backgroundView: UIImageView { get }
    var backgroundColor: UIColor { get }
    var characters: [Character] { get }
    var cellId: String { get }
    
}

final class FavouriteViewModel: FavouriteViewModelProtocol {
    let dependencies: HasDataController
    var backgroundView = UIImageView(image: UIImage(named: "tlo-kopia"))
    var backgroundColor = UIColor(red: 0, green: 28, blue: 41)
    var characters = [Character]()
    let cellId = "cellId"
    
    init(dependencies: HasDataController) {
        self.dependencies = dependencies
    }

}
