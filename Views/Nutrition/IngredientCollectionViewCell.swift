//
//  IngredientCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 31/01/2024.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    static let identifier = "IngredientCollectionViewCell"
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
        
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
    
    private let cookingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Cooking time"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ingredientLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Ingredients:"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Instruction:"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
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
        
      
        contentView.addSubview(nameLabel)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(caloriesImageView)
        contentView.addSubview(timeImageView)
        contentView.addSubview(cookingLabel)
        contentView.addSubview(ingredientLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(instructionLabel)
        contentView.addSubview(instructionsLabel)
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            // nameLabel constraints
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // caloriesImageView constraints
            caloriesImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            caloriesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            caloriesImageView.widthAnchor.constraint(equalToConstant: 20),
            caloriesImageView.heightAnchor.constraint(equalToConstant: 20),

            // caloriesLabel constraints
            caloriesLabel.centerYAnchor.constraint(equalTo: caloriesImageView.centerYAnchor),
            caloriesLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 4),

            // timeImageView constraints
            timeImageView.topAnchor.constraint(equalTo: caloriesImageView.bottomAnchor, constant: 8),
            timeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            timeImageView.widthAnchor.constraint(equalToConstant: 20),
            timeImageView.heightAnchor.constraint(equalToConstant: 20),

            // cookingLabel constraints
            cookingLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            cookingLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 4),

            // timeLabel constraints
            timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: cookingLabel.trailingAnchor, constant: 4),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            timeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            // ingredientLabel constraints
            ingredientLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 18),
            ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            ingredientLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            ingredientLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            
            ingredientsLabel.topAnchor.constraint(equalTo: ingredientLabel.bottomAnchor, constant: 8),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            ingredientsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            
            instructionLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 18),
            instructionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            instructionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            instructionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            instructionsLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 18),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            instructionsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    
    public func configure(viewModel: Food) {
        caloriesLabel.text = String(describing: viewModel.kcal) + " kcal"
        timeLabel.text = String(describing: viewModel.time) + " mins"

        // Join the array of ingredients into a single string
        let ingredientsText = viewModel.ingredients.joined(separator: ", ")

        // Assign the single string to ingredientsLabel.text
        ingredientsLabel.text = "Ingredients: \(ingredientsText)"
        
        instructionsLabel.text = viewModel.instructions
    }

}
