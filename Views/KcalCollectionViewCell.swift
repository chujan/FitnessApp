//
//  KcalCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 07/01/2024.
//

import UIKit

class KcalCollectionViewCell: UICollectionViewCell {
    static let identifier = "KcalCollectionViewCell"
    
    let loveImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.contentMode = .scaleAspectFit
         
        let loveImage = UIImage(systemName: "flame")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
         imageView.image = loveImage
          imageView.translatesAutoresizingMaskIntoConstraints = false
          return imageView
      }()
    
    
    private var kcalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var avgKcalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Calories"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray5
               contentView.layer.cornerRadius = 12
               contentView.layer.borderWidth = 1.0
               contentView.layer.borderColor = UIColor.white.cgColor
          
        contentView.addSubview(loveImageView)
        contentView.addSubview(kcalLabel)
        contentView.addSubview(avgKcalLabel)
        setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            loveImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            loveImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            loveImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            avgKcalLabel.topAnchor.constraint(equalTo: loveImageView.bottomAnchor, constant: 8),
            avgKcalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avgKcalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            kcalLabel.topAnchor.constraint(equalTo: avgKcalLabel.bottomAnchor, constant: 8),
            kcalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            kcalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    func configure(exercise: Exercises) {
           // Configure Kcal cell
           if let caloriesBurned = exercise.caloriesBurned {
               kcalLabel.text = "\(caloriesBurned) kcal"
           } else {
               kcalLabel.text = "N/A"
           }
           // Additional configurations specific to Kcal
           // ...
       }
}
