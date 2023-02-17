//
//  HouseHeader.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 13/02/2023.
//

import UIKit

final class HouseHeader: UITableViewHeaderFooterView {
    
    lazy var houseHeader: UILabel = {
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.font = UIFont(name: "Cochin-Bold", size: 22)
        header.textColor = UIColor.white
        header.text = "Members of house"
        header.textAlignment = .center
        return header
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    private func setupSubviews() {
        addSubview(houseHeader)
        
        NSLayoutConstraint.activate([
            houseHeader.centerXAnchor.constraint(equalTo: centerXAnchor),
            houseHeader.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12),
            houseHeader.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            houseHeader.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8),
           
        ])
    }
}
