//
//  MainCollectionHeaderView.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 18/08/2022.
//

import UIKit

class MainCollectionHeaderView: UICollectionReusableView {
    // TODO: NSLayoutConstraint like in Cell
    
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Hogwart's houses"
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
