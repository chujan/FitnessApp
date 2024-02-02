//
//  NewWorkoutCollectionViewCell.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 13/12/2023.
//

import UIKit
import AVKit

class NewWorkoutCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewWorkoutCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var videoURL: URL?

    var playVideoHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(playButton)
        contentView.layer.cornerRadius = 15

        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)

        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            playButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 40),
            playButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    public func configure(viewModel: Exercises) {
        nameLabel.text = viewModel.name

        if let imageName = viewModel.imageName, let image = UIImage(named: imageName) {
            imageView.image = image
        } else if let placeholderName = viewModel.placeholderImageName, let placeholderImage = UIImage(named: placeholderName) {
            imageView.image = placeholderImage
        } else if let defaultPlaceholderImage = UIImage(named: "default_placeholder") {
            imageView.image = defaultPlaceholderImage
        } else {
            print("Error: Default placeholder image is missing.")
        }

        // Set the video URL
        if let videoURLString = viewModel.videoURL {
            self.videoURL = URL(string: videoURLString)
            playButton.isHidden = true
        } else {
            playButton.isHidden = true
        }
    }

    @objc private func playButtonTapped() {
        if let videoURL = videoURL {
            print("Playing video with URL: \(videoURL)")
            playVideo(url: videoURL)
        } else {
            print("Error: Video URL is nil.")
        }
    }

    private func playVideo(url: URL) {
        print("Setting up AVPlayer with URL: \(url)")
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(playerViewController, animated: true) {
                player.play()
                print("Video playback started.")
            }
        }
    }

   
}
