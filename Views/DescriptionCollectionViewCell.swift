//
//  descriptionCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 30/12/2023.
//

import UIKit


class DescriptionCollectionViewCell: UICollectionViewCell {
    var startButtonTappedHandler: (() -> Void)?
    
   
    static let identifier = "DescriptionCollectionViewCell"
    private var setLabelTopConstraint: NSLayoutConstraint!
    private var roundLabelTopConstraint: NSLayoutConstraint!
    private var setsLabelTopConstraint: NSLayoutConstraint!
    private var repLabelContraint: NSLayoutConstraint!
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
           button.isEnabled = true
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.0 // Set the border width
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitle("Let's Start", for: .normal)
       
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        return button
    }()
    
    
    private let roundLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false

        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "figure.walk") // Replace with your system image name

        // Set the bounds if needed
        attachment.bounds = CGRect(x: 0, y: -2, width: 35, height: 35)

        // Create an attributed string with the attachment
        let attributedText = NSMutableAttributedString(attachment: attachment)
        label.attributedText = attributedText

        return label
    }()

    private let readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Why you should go for it?"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let setLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Programm"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let setsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelAction(gesture:)))
        contentView.addSubview(label)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(readMoreButton)
        contentView.addSubview(setLabel)
        contentView .addSubview(roundLabel)
        contentView.addSubview(setsLabel)
        contentView.addSubview(repLabel)
        contentView.addSubview(startButton)
        setUpContraint()
        contentView.bringSubviewToFront(readMoreButton)
        readMoreButton.addGestureRecognizer(tap)
        readMoreButton.setTitle("Read more", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func labelAction(gesture: UITapGestureRecognizer) {
        if descriptionLabel.numberOfLines == 0 {
            descriptionLabel.numberOfLines = 2
            readMoreButton.isHidden = false
        } else {
            descriptionLabel.numberOfLines = 0
            readMoreButton.isHidden = true
        }
        
        // Update constraints based on the state of the descriptionLabel
        updateConstraintsForDescriptionLabel()
    }
    
    @objc private func startButtonTapped() {
           startButtonTappedHandler?()
       }

    
    private func updateConstraintsForDescriptionLabel() {
        if descriptionLabel.numberOfLines == 0 {
            // If descriptionLabel is expanded, move setLabel down
            setLabelTopConstraint.isActive = false
            roundLabelTopConstraint.isActive = false
        } else {
            // If descriptionLabel is collapsed, move setLabel back up
            setLabelTopConstraint.isActive = true
            roundLabelTopConstraint.isActive = true
        }
    }

    private func setUpContraint() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            readMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -22),
            readMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            
            setLabel.topAnchor.constraint(equalTo: readMoreButton.bottomAnchor, constant: 10),
            setLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            setLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            roundLabel.topAnchor.constraint(equalTo: setLabel.bottomAnchor, constant: 10),
            roundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            roundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            setsLabel.topAnchor.constraint(equalTo: roundLabel.topAnchor),
            setsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            
            repLabel.topAnchor.constraint(equalTo: roundLabel.topAnchor),
            repLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            startButton.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: 50),
                    startButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
                    startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
                    startButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),

                    startButton.heightAnchor.constraint(equalToConstant: 40),


            
        ])
        
        // Additional constraints related to the state of the descriptionLabel
        setLabelTopConstraint = setLabel.topAnchor.constraint(equalTo: readMoreButton.bottomAnchor, constant: 10)
        setLabelTopConstraint.isActive = true
        
        roundLabelTopConstraint = roundLabel.topAnchor.constraint(equalTo: setLabel.bottomAnchor, constant: 10)
        roundLabelTopConstraint.isActive = true
        
       
    }


    
    public func configure(viewModel: Exercises) {
        descriptionLabel.text = viewModel.description
        
        // Convert the Int? to a String?
        if let sets = viewModel.set {
            setsLabel.text = "\(sets)\nset"
        } else {
            setsLabel.text = nil
        }
        
        if let rep = viewModel.rep {
           repLabel.text = "\(rep)\nrep"
        } else {
            repLabel.text = nil
        }
    }


}

