//
//  NotificationViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 19/01/2024.
//

import UIKit
import UserNotifications
import CoreData



class NotificationViewController: UIViewController {
    var notificationMessage: String?

    private var notificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        view.addSubview(notificationLabel)
        setupConstraints()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let message = notificationMessage {
            notificationLabel.text = message
        }
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            notificationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            notificationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notificationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notificationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
