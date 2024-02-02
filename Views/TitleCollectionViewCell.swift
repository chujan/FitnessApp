//
//  TitleCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 16/01/2024.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = " TitleCollectionViewCell"
        private let  stackViewTitleLabel : UILabel = {
            let label = UILabel()
            label.text = "Workout Programms"
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(stackViewTitleLabel)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpViews() {
        NSLayoutConstraint.activate([
            stackViewTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackViewTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
      
        
    }
    public func configure() {
        stackViewTitleLabel.text = "Workout Programms"
    }
    
    
    
}
