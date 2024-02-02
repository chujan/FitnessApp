//
//  ActivitiesCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 16/01/2024.
//

import UIKit

class ActivitiesCollectionViewCell: UICollectionViewCell {
  
    
    static let identifier = "ActivitiesCollectionViewCell"
    private let progressView: CircularProgressView = {
        var  progressView = CircularProgressView()
        progressView = CircularProgressView(frame: CGRect(x: 50, y: 50, width: 90, height: 130))
       
        
        progressView.progress = 0.55
        
       
        return progressView
    }()
    private var progress: Int = 0 {
        didSet {
            // Update the progress bar when the progress value changes
            progressView.progress = CGFloat(progress) / 100.0
        }
    }
    private func updateProgressLabel(_ progress: Int) {
        progressLabel.text = "\(progress)%"
       }
    
   
    
    private let  workOutLabel : UILabel = {
        let label = UILabel()
        label.text = "Workout"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let activitiesLabel : UILabel = {
        let label = UILabel()
        label.text = "Your activities today"
        //label.textAlignment = .left
      
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
   
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        
           label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
          
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "flame.fill") // Replace with your system image name

        // Set the bounds if needed
        attachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18) // Adjust the values as needed

        // Create an NSAttributedString with the attachment and duration
        let attributedString = NSMutableAttributedString(attachment: attachment)
        attributedString.append(NSAttributedString(string: "100kcal"))

        // Set the NSAttributedString as the text of the label
        label.attributedText = attributedString
         
        return label
    }()
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
       
       
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "heart.fill") // Replace with your system image name

        // Set the bounds if needed
        attachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18) // Adjust the values as needed

        // Create an NSAttributedString with the attachment and duration
        let attributedString = NSMutableAttributedString(attachment: attachment)
        attributedString.append(NSAttributedString(string: "80 bpm"))

        // Set the NSAttributedString as the text of the label
        label.attributedText = attributedString
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)

        // Create an NSTextAttachment with your image
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "clock.fill") // Replace with your system image name

        // Set the bounds if needed
        attachment.bounds = CGRect(x: 0, y: -2, width: 13, height: 13) // Adjust the values as needed

        // Create an NSAttributedString with the attachment and duration
        let attributedString = NSMutableAttributedString(attachment: attachment)
        attributedString.append(NSAttributedString(string: " 1 hour"))

        // Set the NSAttributedString as the text of the label
        label.attributedText = attributedString

        return label
    }()
    private let workoutStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
       
        //stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 10
        //stackView.spacing = 10
        stackView.layer.cornerRadius = 10
        
       // stackView.backgroundColor = .systemGreen
        
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [caloriesLabel, heartLabel, timeLabel])
        stackView.axis = .horizontal
        //stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    private let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true // Adjust the height as needed
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(workoutStackView)
        contentView.addSubview(progressView)
         progressView.addSubview(workOutLabel)
         progressView.addSubview(progressLabel)
        workoutStackView.addArrangedSubview(activitiesLabel)
        workoutStackView.addArrangedSubview(labelsStackView)
        contentView.backgroundColor = UIColor.green.withAlphaComponent(0.5) // Adjust alpha as needed

        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.white.cgColor
      
        
       
        
      
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        
        workoutStackView.translatesAutoresizingMaskIntoConstraints = false
       // stackViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
       workOutLabel.translatesAutoresizingMaskIntoConstraints = false
        activitiesLabel.translatesAutoresizingMaskIntoConstraints = false
        heartLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spacerView.heightAnchor.constraint(equalToConstant: 40),
            workoutStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            workoutStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            workoutStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            workoutStackView.heightAnchor.constraint(equalToConstant: 150),
           

            progressView.widthAnchor.constraint(equalToConstant: 90),
                progressView.heightAnchor.constraint(equalToConstant: 130),
            progressView.trailingAnchor.constraint(equalTo: workoutStackView.trailingAnchor, constant: -10),
          
    
            progressLabel.widthAnchor.constraint(equalToConstant: 100),
            progressLabel.heightAnchor.constraint(equalToConstant: 90),

            workOutLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: -20),
           // workOutLabel.heightAnchor.constraint(equalToConstant: 10),
            workOutLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: -20),

           activitiesLabel.topAnchor.constraint(equalTo: workoutStackView.topAnchor, constant: 50),
                activitiesLabel.leadingAnchor.constraint(equalTo: workoutStackView.leadingAnchor, constant: 20),
            activitiesLabel.trailingAnchor.constraint(equalTo: workoutStackView.trailingAnchor,constant: -150),
            activitiesLabel.heightAnchor.constraint(equalToConstant: 20),
            labelsStackView.topAnchor.constraint(equalTo: activitiesLabel.bottomAnchor, constant: 120),
            labelsStackView.leadingAnchor.constraint(equalTo: workoutStackView.leadingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: workoutStackView.trailingAnchor, constant: -8),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20),

            caloriesLabel.leadingAnchor.constraint(equalTo: labelsStackView.leadingAnchor, constant: 8),
            caloriesLabel.widthAnchor.constraint(equalTo: labelsStackView.widthAnchor, multiplier: 1.0/3.0),
            //caloriesLabel.centerYAnchor.constraint(equalTo: labelsStackView.centerYAnchor),

            heartLabel.leadingAnchor.constraint(equalTo: caloriesLabel.trailingAnchor, constant: 15), // Add spacing (adjust constant as needed)
            heartLabel.widthAnchor.constraint(equalTo: labelsStackView.widthAnchor, multiplier: 1.0/3.0), // Adjust multiplier as needed

            timeLabel.leadingAnchor.constraint(equalTo: heartLabel.trailingAnchor, constant: 15), // Add spacing (adjust constant as needed)
            timeLabel.widthAnchor.constraint(equalTo: labelsStackView.widthAnchor, multiplier: 1.0/3.0),
            //timeLabel.trailingAnchor.constraint(equalTo: labelsStackView.trailingAnchor),
        ])
       
    }
    
    public func configure(progress: Int, workoutTitle: String, activitiesTitle: String, calories: String, heartRate: String, time: String) {
        self.progress = progress
        progressLabel.text = "\(progress)%"
           // Set the workout title
           workOutLabel.text = workoutTitle
           
           // Set the activities title
           activitiesLabel.text = activitiesTitle
        caloriesLabel.text = " \(calories)kcal"
        heartLabel.text = "\(heartRate)bmp"
        timeLabel.text  = " \(time)mins"
           
           // Set the labels with the provided values
           caloriesLabel.attributedText = createAttributedString(imageName: "flame.fill", value: calories)
           heartLabel.attributedText = createAttributedString(imageName: "heart.fill", value: heartRate)
           timeLabel.attributedText = createAttributedString(imageName: "clock.fill", value: time)
      
           
           // Update the progress label
         
       }
       
       private func createAttributedString(imageName: String, value: String) -> NSAttributedString {
           let attachment = NSTextAttachment()
           attachment.image = UIImage(systemName: imageName)
           attachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18)

           let attributedString = NSMutableAttributedString(attachment: attachment)
           attributedString.append(NSAttributedString(string: " \(value)"))

           return attributedString
       }
   


    
    
}
