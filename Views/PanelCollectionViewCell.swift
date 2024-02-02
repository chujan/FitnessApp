//
//  PanelCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 28/12/2023.
//

import UIKit

class PanelCollectionViewCell: UICollectionViewCell {
    static let identifier = "PanelCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label  = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    public func configure(viewModel: Exercises) {
        print("Configuring cell with ExerciseViewModel: \(viewModel)")

        nameLabel.text = viewModel.name

        // Assuming your viewModel has an exercise type and imageName properties
        if let imageName = viewModel.imageName, let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            // Handle the case where the imageName is invalid or nil
            if let placeholderName = viewModel.placeholderImageName, let placeholderImage = UIImage(named: placeholderName) {
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
