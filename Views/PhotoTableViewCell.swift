//
//  PhotoTableViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 17/01/2024.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    static let identifier = "PhotoTableViewCell"

    private let backgroundViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        let heartImage = UIImage(systemName: "gauge.high")?.withTintColor(.white, renderingMode: .automatic)
        imageView.image = heartImage

        return imageView
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(backgroundViewContainer)
        backgroundViewContainer.addSubview(myImageView)
        myImageView.tintColor = .white
      
        
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        NSLayoutConstraint.activate([
            backgroundViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backgroundViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            backgroundViewContainer.widthAnchor.constraint(equalToConstant: 50),
            backgroundViewContainer.heightAnchor.constraint(equalToConstant: 60),

            myImageView.centerXAnchor.constraint(equalTo: backgroundViewContainer.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: backgroundViewContainer.centerYAnchor),
            myImageView.widthAnchor.constraint(equalTo: backgroundViewContainer.widthAnchor, multiplier: 0.8), // Adjust the multiplier
            myImageView.heightAnchor.constraint(equalTo: backgroundViewContainer.heightAnchor, multiplier: 0.8), // Adjust the multiplier


            caloriesLabel.leadingAnchor.constraint(equalTo: backgroundViewContainer.trailingAnchor, constant: 13),
            caloriesLabel.centerYAnchor.constraint(equalTo: backgroundViewContainer.centerYAnchor)
        ])
    }

    func configure(image: UIImage?, calories: String) {
        myImageView.image = image ?? UIImage(systemName: "gauge.high")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        caloriesLabel.text = calories
    }
}
class ProfleSetting: UITableViewCell {

    static let identifier = "ProfleSetting"

    private let backgroundViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        let heartImage = UIImage(systemName: "gauge.high")?.withTintColor(.white, renderingMode: .automatic)
        imageView.image = heartImage

        return imageView
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(backgroundViewContainer)
        backgroundViewContainer.addSubview(myImageView)
        myImageView.tintColor = .white
      
        
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        NSLayoutConstraint.activate([
            backgroundViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backgroundViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            backgroundViewContainer.widthAnchor.constraint(equalToConstant: 50),
            backgroundViewContainer.heightAnchor.constraint(equalToConstant: 60),

            myImageView.centerXAnchor.constraint(equalTo: backgroundViewContainer.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: backgroundViewContainer.centerYAnchor),
            myImageView.widthAnchor.constraint(equalTo: backgroundViewContainer.widthAnchor, multiplier: 0.8), // Adjust the multiplier
            myImageView.heightAnchor.constraint(equalTo: backgroundViewContainer.heightAnchor, multiplier: 0.8), // Adjust the multiplier


            caloriesLabel.leadingAnchor.constraint(equalTo: backgroundViewContainer.trailingAnchor, constant: 13),
            caloriesLabel.centerYAnchor.constraint(equalTo: backgroundViewContainer.centerYAnchor)
        ])
    }

    func configure(image: UIImage?, calories: String) {
        myImageView.image = image ?? UIImage(systemName: "gauge.high")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        caloriesLabel.text = calories
    }
}
class LogOutTableViewCell: UITableViewCell {

    static let identifier = "LogOutTableViewCell"

    private let backgroundViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        let heartImage = UIImage(systemName: "gauge.high")?.withTintColor(.white, renderingMode: .automatic)
        imageView.image = heartImage

        return imageView
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(backgroundViewContainer)
        backgroundViewContainer.addSubview(myImageView)
        myImageView.tintColor = .white
      
        
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        NSLayoutConstraint.activate([
            backgroundViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backgroundViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            backgroundViewContainer.widthAnchor.constraint(equalToConstant: 50),
            backgroundViewContainer.heightAnchor.constraint(equalToConstant: 60),

            myImageView.centerXAnchor.constraint(equalTo: backgroundViewContainer.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: backgroundViewContainer.centerYAnchor),
            myImageView.widthAnchor.constraint(equalTo: backgroundViewContainer.widthAnchor, multiplier: 0.6), // Adjust the multiplier
            myImageView.heightAnchor.constraint(equalTo: backgroundViewContainer.heightAnchor, multiplier: 0.6), // Adjust the multiplier


            caloriesLabel.leadingAnchor.constraint(equalTo: backgroundViewContainer.trailingAnchor, constant: 13),
            caloriesLabel.centerYAnchor.constraint(equalTo: backgroundViewContainer.centerYAnchor)
        ])
    }

    func configure(image: UIImage?, calories: String) {
        myImageView.image = image ?? UIImage(systemName: "gauge.high")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        caloriesLabel.text = calories
    }
}
