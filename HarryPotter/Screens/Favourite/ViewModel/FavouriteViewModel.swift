//
//  FavouriteViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 28/09/2022.
//

import UIKit

protocol FavouriteViewModelProtocol {
    var backgroundView: UIImageView { get }
    var backgroundColor: UIColor { get }
    var userKey: String { get }
    var characters: [Character] { get }
}

final class FavouriteViewModel: FavouriteViewModelProtocol {
    var backgroundView = UIImageView(image: UIImage(named: "tlo-kopia"))
    var backgroundColor = UIColor(red: 0, green: 28, blue: 41)
    var userKey = "userKey"
    var characters = [Character]()
    
    init() {
        
    }
}
