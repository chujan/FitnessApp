//
//  InstructionCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 31/01/2024.
//

import UIKit

class InstructionCollectionViewCell: UICollectionViewCell {
    static let identifier = "InstructionCollectionViewCell"
   
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
        contentView.layer.cornerRadius = 12
        contentView.addSubview(imageView)
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
            ])
            }
    public func configure(viewModel: Food) {
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
