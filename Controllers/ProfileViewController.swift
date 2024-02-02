//
//  ProfileViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 19/01/2024.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fitness") // Replace with your actual Core Data model name
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()
}





class ProfileViewController: UIViewController {
    let coreDataManager = CoreDataManager.shared
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Create password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your age"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(firstNameTextField)
        view.addSubview(ageTextField)
        view.addSubview(saveButton)
       // saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        // Add the scroll view to the main view
        
        
        // Add constraints for the scroll view and text fields
        NSLayoutConstraint.activate([
            
            
            firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +60),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            ageTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            saveButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            
        ])
    }
//    @objc func saveButtonPressed() {
//        // Save user data when the user presses the save button
//        saveUserData()
//    }
//    func saveUserData() {
//        let context = coreDataManager.persistentContainer.viewContext
//
//        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)
//
//        // Make sure the entity and context are valid before proceeding
//        guard let entity = userEntity, let user = NSManagedObject(entity: entity, insertInto: context) as? User else {
//            print("Error creating User object.")
//            return
//        }
//
//        user.firstName = firstNameTextField.text
//        // ... (set other user data properties)
//
//        do {
//            try context.save()
//            print("User data saved successfully.")
//        } catch {
//            print("Error saving user data: \(error.localizedDescription)")
//        }
//    }
//    func loadUserData() {
//        let context = coreDataManager.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<User>(entityName: "User")
//
//        do {
//            let users = try context.fetch(fetchRequest)
//            if let user = users.first {
//                firstNameTextField.text = user.firstName
//                lastNameTextField.text = user.lastName
//                emailTextField.text = user.email
//                passwordTextField.text = user.password
//                ageTextField.text = user.age
//
//            }
//        } catch {
//            print("Error fetching user data: \(error.localizedDescription)")
//        }
//    }

    
}
      
    

