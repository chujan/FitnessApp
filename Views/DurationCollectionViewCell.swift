//
//  DurationCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 09/01/2024.
//

import UIKit

class DurationCollectionViewCell: UICollectionViewCell {
    static let identifier = "DurationCollectionViewCell"
    func formattedTimeString(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: TimeInterval(seconds)) ?? "hrs"
    }
    
    
    let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        let timeImage = UIImage(systemName: "clock.arrow.circlepath")?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        imageView.image = timeImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    private var avgTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Time"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    func updateDuration(durationInHours: Double) {
       // Convert hours to seconds
        timeLabel.text = "\(durationInHours) mins"
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.cyan.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.white.cgColor
        
        
        addSubview(timeImageView)
        addSubview(avgTimeLabel)
        addSubview(timeLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // Add constraints for kcalLabel
            
            
            timeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            timeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            timeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            timeImageView.heightAnchor.constraint(equalToConstant: 20),
            
            avgTimeLabel.topAnchor.constraint(equalTo: timeImageView.bottomAnchor, constant: 8),
            avgTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: +17),
            avgTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: avgTimeLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            
            
        ])
    }
    
    
    
    // ... existing code ...
    
    
    public func configure(time: Double) {
        timeLabel.text = "\(time) mins"
    }
    
}
