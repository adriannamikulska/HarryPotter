//
//  FavouriteCell.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 28/09/2022.
//

import UIKit

final class FavouriteMemberCell: UITableViewCell {
    
     lazy var memberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Cochin-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        downloadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func downloadView() {
        contentView.addSubview(memberLabel)
        
        NSLayoutConstraint.activate([
            memberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            memberLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            memberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            memberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
