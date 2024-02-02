//
//  CaloriesCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 09/01/2024.
//

import UIKit

class CaloriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CaloriesCollectionViewCell"
   
    
    
      
    
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
    
    func updateCalories(calories: Double) {
        // Round the calories value to two decimal places
        let roundedCalories = String(format: "%.2f", calories)
        
        // Update the label text
        kcalLabel.text = "\(calories) Kcal"
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.1) // Adjust alpha as needed

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
    public func configure(viewModel: Exercises) {
        kcalLabel.text = "\(viewModel.caloriesBurned ?? 0.0)"
    }
    
}
