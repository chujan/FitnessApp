//
//  VegetarianCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 27/01/2024.
//

import UIKit

class VegetarianCollectionViewCell: UICollectionViewCell {
    static let identifier = "VegetarianCollectionViewCell"
    private let nameLabel: UILabel  = {
        let label = UILabel()
        label .translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let decriptionLabel: UILabel  = {
        let label = UILabel()
        label .translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(decriptionLabel)
        contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.4) // Adjust alpha as needed

        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.white.cgColor
        setUpContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContraint() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            decriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            decriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            decriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
     
        
    }
    
    public func configure(vege: Nutrition) {
        nameLabel.text = vege.category
        decriptionLabel.text = vege.description
    }
    
    
}

