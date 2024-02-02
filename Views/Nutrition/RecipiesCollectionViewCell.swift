//
//  RecipiesCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 30/01/2024.
//

import UIKit

class RecipiesCollectionViewCell: UICollectionViewCell {
    static let idenifier = "RecipiesCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
        
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let caloriesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "flame")
        imageView.tintColor = .red // Adjust the tint color as needed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.tintColor = .purple// Adjust the tint color as needed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(caloriesImageView)
        contentView.addSubview(timeImageView)
        setUpContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 155),
           
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
                   nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                   nameLabel.heightAnchor.constraint(equalToConstant: 20),
                   nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),

                   caloriesImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
                   caloriesImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
                   caloriesImageView.heightAnchor.constraint(equalToConstant: 18),
                   caloriesImageView.widthAnchor.constraint(equalToConstant: 18),

                   caloriesLabel.topAnchor.constraint(equalTo: caloriesImageView.topAnchor),
                   caloriesLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 5),
                   caloriesLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),

                   timeImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
                   timeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
                   timeImageView.heightAnchor.constraint(equalToConstant: 18),
                   timeImageView.widthAnchor.constraint(equalToConstant: 18),

                   timeLabel.topAnchor.constraint(equalTo: timeImageView.topAnchor),
                   timeLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 5),
                   timeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),
        ])
       
    }
    
    public func configure(viewmodel: Food) {
        nameLabel.text = viewmodel.name
        
        caloriesLabel.text = String(describing: viewmodel.kcal) + " kcal"
        timeLabel.text = String(describing: viewmodel.time) + " mins"
      
   
        if let imageName = viewmodel.imageName, let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            // Handle the case where the imageName is invalid or nil
            if let placeholderName = viewmodel.placeholderImageName, let placeholderImage = UIImage(named: placeholderName) {
                imageView.image = placeholderImage
            } else {
                // Default placeholder image if no specific placeholder is defined
                if let defaultPlaceholderImage = UIImage(named: "default_placeholder") {
                    imageView.image = defaultPlaceholderImage
                } else {
                    // Handle the case where the default placeholder image is missing
                    // This could be a fallback image or an error handling strategy
                    print("Error: Default placeholder image is missing.")
                }
            }
        }
        
    }
    
   
    
}
