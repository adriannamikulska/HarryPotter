//
//  MainViewModel.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 18/08/2022.
//

import UIKit

final class MainViewModel {
    
    enum Images: Int {
        case item0 = 0
        case item1 = 1
        case item2 = 2
        case item3 = 3
        case item4 = 4
        case item5 = 5
        case item6 = 6
        case item7 = 7
        case item8 = 8
        case item9 = 9
        
        var nameImage: UIImage?{
            switch self {
            case .item0: return UIImage(named: "0")
            case .item1: return UIImage(named: "1")
            case .item2: return UIImage(named: "2")
            case .item3: return UIImage(named: "3")
            case .item4: return UIImage(named: "4")
            case .item5: return UIImage(named: "5")
            case .item6: return UIImage(named: "6")
            case .item7: return UIImage(named: "7")
            case .item8: return UIImage(named: "8")
            case .item9: return UIImage(named: "9")
            }
        }
    }
    
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
    
    let screenTitle: String = "Harry Potter"
    let backTitle: String = "Back"
    let backgroundColor = UIColor(red: 0, green: 28, blue: 41)

    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
