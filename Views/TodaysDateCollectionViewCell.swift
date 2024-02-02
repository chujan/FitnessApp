//
//  Today'sDateCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 08/01/2024.
//

import UIKit


class TodaysDateCollectionViewCell: UICollectionViewCell {
    static let identifier = "TodaysDateCollectionViewCell"
    
    private let todayDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(todayDateLabel)
        setUpConstraints()
        configureTodayDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            todayDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            todayDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            todayDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
    }
    
    public func configureTodayDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        let currentDate = dateFormatter.string(from: Date())
        todayDateLabel.text = currentDate
        todayDateLabel.textColor = .black
        // You can customize the label further if needed
        // For example, you can set a specific font, size, or apply other styling
        todayDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
}
