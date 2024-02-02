//
//  Pro.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 17/01/2024.
//

import UIKit



class ProfileSectionHeaderView: UITableViewHeaderFooterView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var currentUser: User? {
            didSet {
               
            }
        }
    static let identifier = "ProfileSectionHeaderView"
    
    var profileImageView: UIImageView? {
        didSet {
            oldValue?.removeFromSuperview()

            if let profileImageView = profileImageView {
                addSubview(profileImageView)
                profileImageView.translatesAutoresizingMaskIntoConstraints = false
                profileImageView.contentMode = .scaleAspectFit
                profileImageView.layer.cornerRadius = profileImageView.bounds.width / 4
                profileImageView.clipsToBounds = true

                NSLayoutConstraint.activate([
                    profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: -10),
                    profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    // Maintain a square aspect ratio
                    profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                   
                ])

                addSubview(changePictureButton)
                NSLayoutConstraint.activate([
                    changePictureButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                    changePictureButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
                ])

                // Set the target action for the button
                changePictureButton.addTarget(self, action: #selector(changeProfilePictureTapped), for: .touchUpInside)
            }
        }
    }

    var nameLabel: UILabel? {
        didSet {
            oldValue?.removeFromSuperview()

            if let nameLabel = nameLabel {
                addSubview(nameLabel)
                nameLabel.translatesAutoresizingMaskIntoConstraints = false
                nameLabel.textColor = .black
                nameLabel.textAlignment = .center
                nameLabel.font = .systemFont(ofSize: 16, weight: .medium)

                NSLayoutConstraint.activate([
                    nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                    nameLabel.topAnchor.constraint(equalTo: profileImageView?.bottomAnchor ?? topAnchor, constant: 200),
                ])
            }
        }
    }
    
    func updateNameLabel(with user: User) {
            nameLabel?.text = "\(user.firstName) \(user.lastName)"
        }
    
  


    private let changePictureButton: UIButton = {
        let button = UIButton()
        let cameraImage = UIImage(systemName: "camera")
        button.setImage(cameraImage, for: .normal)
        button.tintColor = .systemGray
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
        setupUserInfo()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func commonInit() {
        nameLabel = UILabel()

        // Set initial values for the nameLabel using currentUser
        if let currentUser = currentUser {
            nameLabel?.text = "\(currentUser.firstName) \(currentUser.lastName)"
            print("Name label set with user: \(currentUser.firstName) \(currentUser.lastName)")
        } else {
            nameLabel?.text = ""  // Set a default name if currentUser is nil
            print("Name label set with default name because currentUser is nil.")
        }

        // You can set the default name or retrieve it from your data source

        // Set the target action for the button
        changePictureButton.addTarget(self, action: #selector(changeProfilePictureTapped), for: .touchUpInside)
    }

    
    @objc private func changeProfilePictureTapped() {
        showImagePickerOption()
    }
    func setupUserInfo() {
        if let userDict = UserDefaults.standard.dictionary(forKey: "currentUser") {
            currentUser = User(
                uid: userDict["uid"] as! String,
                firstName: userDict["firstName"] as! String,
                lastName: userDict["lastName"] as! String,
                email: userDict["email"] as! String
            )

            // Now, use `currentUser` as needed in your header view
            // For example, set user's name, profile image, etc.
            nameLabel?.text = "\(currentUser?.firstName ?? "") \(currentUser?.lastName ?? "")"
            // Set other UI elements with user information as needed
        }
    }


    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    private func showImagePickerOption() {
        let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose a picture from Library or camera", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
            guard let self = self else {
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.window?.rootViewController?.present(cameraImagePicker, animated: true, completion: nil)
        }
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            guard let self = self else {
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.window?.rootViewController?.present(libraryImagePicker, animated: true) {}
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)
        self.window?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            saveProfileImage(image)
            let circularImage = image.circularImage(with: (profileImageView?.bounds.size)!)
            profileImageView?.image = circularImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    private func saveProfileImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "profileImageData")
            UserDefaults.standard.synchronize()
        }
    }

    private func loadProfileImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: "profileImageData"),
           let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
}

extension UIImage {
    func circularImage(with size: CGSize) -> UIImage {
        let imageSize = size.width > size.height ? CGSize(width: size.height, height: size.height) : size
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        return renderer.image { context in
            let roundedRect = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
            context.cgContext.addEllipse(in: roundedRect)
            context.cgContext.clip()
            draw(in: roundedRect)
        }
    }
}
