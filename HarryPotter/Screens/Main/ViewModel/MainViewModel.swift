//
//  MainViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 18/08/2022.
//

import UIKit

final class MainViewModel {
    
    enum House: Int {
        case griffindor = 0
        case slytherin = 1
        case ravenclaw = 2
        case hufflepuff = 3
        
        var name: String {
            switch self {
            case .griffindor: return "Gryffindor House"
            case .slytherin: return "Slytherin House"
            case .ravenclaw: return "Ravenclaw House"
            case .hufflepuff: return "Hufflepuff House"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .griffindor: return UIImage(named: "gryffindor")
            case .slytherin: return UIImage(named: "slytherin")
            case .ravenclaw: return UIImage(named: "ravenclaw")
            case .hufflepuff: return UIImage(named: "hufflepuff")
            }
        }
    }
    
    let screenTitle: String = "Characters from Harry Potter"
    let backTitle: String = "Back"
    
}
