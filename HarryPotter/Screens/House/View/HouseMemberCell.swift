//
//  HouseMemberCell.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 24/08/2022.
//

import UIKit

final class HouseMemberCell: UITableViewCell {
    
    var markedFavourite: ((Bool) -> Void)?
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Cochin-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var myButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "whiteheart"), for: .normal)
        button.setImage(UIImage(named: "redheart"), for: .selected)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapButton() {
        let wasSelected = myButton.isSelected
        markedFavourite?(wasSelected)
        myButton.isSelected = !wasSelected
    }
    
    func setButtonState(isSelected: Bool) {
        myButton.isSelected = isSelected
    }
    
    func setPersonLabel(text: String) {
        myLabel.text = text
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(myLabel)
        contentView.addSubview(myButton)
        
        NSLayoutConstraint.activate([
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            
            myButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            myButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            myButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }
}

