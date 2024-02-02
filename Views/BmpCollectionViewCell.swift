//
//  BmpCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 07/01/2024.
//

import UIKit

class BmpCollectionViewCell: UICollectionViewCell {
    static let identifier = "BmpCollectionViewCell"
    
    let flameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        let heartImage = UIImage(systemName: "heart")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        imageView.image = heartImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var bpmLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
        private var avgBpmLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "HeartRate"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray5
               contentView.layer.cornerRadius = 12
               contentView.layer.borderWidth = 1.0
               contentView.layer.borderColor = UIColor.white.cgColor
          
        contentView.addSubview(flameImageView)
        contentView.addSubview(bpmLabel)
        contentView.addSubview(avgBpmLabel)
        setUpContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContraint() {
        NSLayoutConstraint.activate([
            flameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             flameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            flameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
              
             avgBpmLabel.topAnchor.constraint(equalTo: flameImageView.bottomAnchor, constant: 8),
              avgBpmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
              avgBpmLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
             
             bpmLabel.topAnchor.constraint(equalTo: avgBpmLabel.bottomAnchor, constant: 8),
             bpmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
             bpmLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
           
        ])
        
        
    }
    func configure(exercise: Exercises) {
            // Configure BPM cell
            if let averageHeartRate = exercise.averageHeartRate {
                bpmLabel.text = "\(averageHeartRate) bmp"
            } else {
                bpmLabel.text = "N/A"
            }
            // Additional configurations specific to BPM
            }
    
}
