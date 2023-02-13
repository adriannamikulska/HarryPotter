//
//  FavouriteHeader.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 13/02/2023.
//

import UIKit

final class FavouriteHeader: UITableViewHeaderFooterView {
    
    lazy var favHeader: UILabel = {
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.textAlignment = .center
        header.font = UIFont(name: "Cochin-Bold", size: 24)
        header.text = "Favorite characters"
        header.textColor = .white
        
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
        addSubview(favHeader)
        
        NSLayoutConstraint.activate([
            favHeader.centerXAnchor.constraint(equalTo: centerXAnchor),
            favHeader.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12),
            favHeader.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            favHeader.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8),
           
        ])
    }
}
