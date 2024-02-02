//
//  WeekCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 19/12/2023.
//

import UIKit

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
    static let identifier = "WeekCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14)
      
        return label
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 10  // Adjust the corner radius based on your design
        view.isHidden = true
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.addSubview(dateLabel)
        contentView.addSubview(dotView)
        // label.frame = contentView.bounds
        dotView.frame = CGRect(x: contentView.bounds.width - 10, y: 5, width: 6, height: 6)  // Adjust the position based on your design
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(dayOfWeek: String, date: String, isToday: Bool) {
        label.text = dayOfWeek
        dateLabel.text = date

        let stackView = UIStackView(arrangedSubviews: [label, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = isToday ? .green : .systemGray5  // Set background color based on isToday
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 5
        stackView.layer.borderColor = UIColor.white.cgColor

        // Set text color of date label based on isToday
        dateLabel.textColor = isToday ? .white : .black

        // Remove existing subviews
        contentView.subviews.forEach { $0.removeFromSuperview() }

        // Add the stack view
        contentView.addSubview(stackView)

        // Add constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10), // Adjust the leading constant for padding
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5), // Adjust the trailing constant for padding
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        // Add the dotView
        contentView.addSubview(dotView)

        // Adjust the position of dotView based on your design
        dotView.frame = CGRect(x: contentView.bounds.width - 15, y: 5, width: 6, height: 6)

        // Ensure dotView is visible or hidden based on isToday
        dotView.isHidden = !isToday
    }


}
