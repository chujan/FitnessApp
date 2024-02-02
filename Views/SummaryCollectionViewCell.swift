//
//  SummaryCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 15/01/2024.
//

import UIKit



class SummaryCollectionViewCell: UICollectionViewCell {
    static let identifier = "SummaryCollectionViewCell"
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Workout Summary"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var exerciseStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var totalExerciseDuration: Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(exerciseStatusLabel)
        setupContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContraint() {
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            exerciseStatusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            exerciseStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            exerciseStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(totalDuration: Double) {
        totalExerciseDuration = totalDuration
        
        if totalExerciseDuration >= 150 {
            // Use NSAttributedString to combine "Excellent!" and the yellow star symbol
            let attributedText = NSMutableAttributedString(string: "Excellent! ", attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: UIColor.systemGreen
            ])
            
            // Add the yellow star symbol to the attributed text
            let starAttachment = NSTextAttachment()
            starAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
            let starString = NSAttributedString(attachment: starAttachment)
            attributedText.append(starString)
            
            // Set the attributed text to the label
            exerciseStatusLabel.attributedText = attributedText
        } else {
            exerciseStatusLabel.text = "Keep it up!"
        }
    }
}
