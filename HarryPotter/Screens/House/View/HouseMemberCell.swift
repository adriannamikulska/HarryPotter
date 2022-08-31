//
//  HouseMemberCell.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 24/08/2022.
//

import UIKit

final class HouseMemberCell: UITableViewCell {
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Cochin-Bold", size: 20)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(myLabel)
        
        NSLayoutConstraint.activate([
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            myLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor)
        ])
    }
}

