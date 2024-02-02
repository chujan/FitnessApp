//
//  WorkoutCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 12/12/2023.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    static let identifier = "WorkoutCollectionViewCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Cell initialized")
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(nameLabel)
        addContraint()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayer() {
            contentView.layer.cornerRadius = 12
            contentView.layer.shadowColor = UIColor.label.cgColor
            contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
            contentView.layer.shadowOpacity = 0.3
        }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    private func addContraint() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
           nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            //nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    public func configure(viewModel: Exercise) {
       
        nameLabel.text = viewModel.name
    }
}
