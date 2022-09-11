//
//  CharacterCell.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 10/09/2022.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var characterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Cochin-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dowlandView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func dowlandView() {
        contentView.addSubview(characterImage)
        contentView.addSubview(characterLabel)
        
        NSLayoutConstraint.activate([
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            
            characterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            characterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -36),
            characterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36)
        ])
    }
}

