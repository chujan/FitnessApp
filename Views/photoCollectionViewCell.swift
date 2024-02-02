//
//  photoCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 29/12/2023.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        
        contentView.layer.cornerRadius = 15
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
           
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configure(viewModel: Exercises) {
        //print("Configuring cell with ExerciseViewModel: \(viewModel)")

       

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
