//
//  WorkoutSummaryCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 21/12/2023.
//

import UIKit

import UIKit
protocol WorkoutSummaryCellDelegate: AnyObject {
    func getTotalCaloriesForType() -> Double
}

class WorkoutSummaryCollectionViewCell: UICollectionViewCell {
    static let identifier = "WorkoutSummaryCollectionViewCell"
    private let lineProgressView: LineProgressView = {
        let  progressView = LineProgressView()
        progressView.frame = CGRect(x: 10, y: 50, width: 300, height: 20)
        progressView.progress = 0.7
        
        return progressView
    }()
    
    private var progress: Int = 0 {
        didSet {
            // Update the progress bar when the progress value changes
            lineProgressView.progress = CGFloat(progress) / 100.0
        }
    }
    var getTotalCaloriesForType: (() -> Double)?
    func formattedTimeString(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: TimeInterval(seconds)) ?? "0m"
    }
    
    let loveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "flame") // You can replace this with your love image name
        imageView.tintColor = UIColor.systemPink // Set the desired color here
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let flameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = UIColor.systemOrange// You can replace this with your love image name
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "clock.arrow.circlepath")
        imageView.tintColor = UIColor.purple
        // You can replace this with your love image name
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center // Set content mode to center
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label  = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray.withAlphaComponent(0.9)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray.withAlphaComponent(0.9)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray.withAlphaComponent(10)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func updateTime(time: Double) {
        let formattedTime = formattedTimeString(from: time)
        timeLabel.text = formattedTime
    }
    
    func updateProgress(progress: Int) {
        progressLabel.text = "\(progress)%"
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(heartLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(lineProgressView)
        contentView.addSubview(loveImageView)
        contentView.addSubview(flameImageView)
        contentView.addSubview(timeImageView)
        contentView.addSubview(startTimeLabel)
        contentView.addSubview(endTimeLabel)
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        
        
        addConstraints()
    }
    
    func updateHeartRate(heartRate: Double) {
        DispatchQueue.main.async {
            self.heartLabel.text = "\(heartRate) bpm"
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: +90),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            lineProgressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            lineProgressView.topAnchor.constraint(equalTo:nameLabel.bottomAnchor, constant: 8),
            lineProgressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            progressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            progressLabel.trailingAnchor.constraint(equalTo: lineProgressView.trailingAnchor, constant: +50),
            
            
            
            caloriesLabel.topAnchor.constraint(equalTo: lineProgressView.bottomAnchor),
            caloriesLabel.trailingAnchor.constraint(equalTo: loveImageView.trailingAnchor, constant: +20),
            caloriesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: +30),
            
            heartLabel.leadingAnchor.constraint(equalTo: caloriesLabel.leadingAnchor, constant: 110),
            heartLabel.centerYAnchor.constraint(equalTo: caloriesLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo:timeImageView.trailingAnchor, constant: +70),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            //loveImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            loveImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -50),
            loveImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            flameImageView.leadingAnchor.constraint(equalTo: heartLabel.leadingAnchor, constant: -25),
            flameImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            timeImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            timeImageView.trailingAnchor.constraint(equalTo:heartLabel.trailingAnchor, constant: +30),
            startTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            startTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            endTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            endTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
            
            //loveImageView.w-30idthAnchor.constraint(equalToConstant: 20), // Adjust the width as needed
            //loveImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    
    public func configure(viewModel: Exercises, totalCalories: Double, progress: Int,  heartRate: Int,durationInMinutes: Double, startTime: Date?, endTime: Date?) {
        
        
        
        
        DispatchQueue.main.async { [weak self] in
            self?.progress = progress
            self?.progressLabel.text = "\(progress)%"
            self?.nameLabel.text = viewModel.name
            self?.heartLabel.text = "\(heartRate)bpm"
            self?.timeLabel.text = "\(durationInMinutes)min"
            //  let totalCaloriesText = String(format: "Total Calories: %.2f", totalCalories)
            self?.caloriesLabel.text = "\(totalCalories)kcal"
            
            // Update the label text
            
            
            
            
        }
        //heartLabel.text = "\(heart) bpm"
        // timeLabel.text = "\(time) hr"
        
        // Assuming your viewModel has an imageName property
        if let imageName = viewModel.imageName {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(systemName: imageName)
                self.imageView.tintColor = UIColor.black // Set the desired image color
            }
        } else {
            // Handle the case where the imageName is invalid or nil
            if let placeholderName = viewModel.placeholderImageName, let placeholderImage = UIImage(named: placeholderName) {
                self.imageView.image = placeholderImage
                self.imageView.tintColor = UIColor.black // Set the desired image color
            } else {
                // Default placeholder image if no specific placeholder is defined
                if let defaultPlaceholderImage = UIImage(named: "default_placeholder") {
                    self.imageView.image = defaultPlaceholderImage
                    self.imageView.tintColor = UIColor.black // Set the desired image color
                } else {
                    // Handle the case where the default placeholder image is missing
                    // This could be a fallback image or an error handling strategy
                    print("Error: Default placeholder image is missing.")
                    self.imageView.tintColor = UIColor.black // Set a default image color
                }
            }
        }
        startTimeLabel.text = viewModel.startTimeString ?? "N/A"

           // Use endTimeString to update your UI element for end time
        endTimeLabel.text = viewModel.endTimeString ?? "N/A"
        
           }
        
    }
    

