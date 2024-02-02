//
//  LoginViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 19/01/2024.
//

import UIKit
import CoreData
import FirebaseAuth
class LoginViewController: UIViewController {
    var profileSectionHeaderView: ProfileSectionHeaderView!

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Let's get rolling"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    
    private let createlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an account to get started"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    private let containlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password should contain\n. At least 8 characters\n. Uppercase and lowercase\n. At least one number or symbol"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0 // Allow multiple lines
        
        return label
    }()

    
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Create password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.isSecureTextEntry = true

        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        } else {
            // Fallback for earlier iOS versions
            textField.autocorrectionType = .no
        }

        textField.rightViewMode = .always

        // Increase right padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 10)) // Adjust the width to increase padding
        let eyeImageView = UIImageView(image: UIImage(systemName: "eye"))
        eyeImageView.tintColor = .darkGray // Adjust the color
        eyeImageView.contentMode = .scaleAspectFit
        paddingView.addSubview(eyeImageView)
        textField.rightView = paddingView

        return textField
    }()

    private let createAccountButton: UIButton = {
           let button = UIButton(type: .system)
           button.layer.cornerRadius = 12
           button.layer.borderWidth = 1.0
           button.layer.borderColor = UIColor.white.cgColor
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Create Account", for: .normal)
           button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
           button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        
           button.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
           return button
       }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
              button.setTitle("Already have an account? Sign In", for: .normal)
              button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
              button.setTitleColor(.black, for: .normal)
              button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
              return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileSectionHeaderView = ProfileSectionHeaderView()
        navigationController?.isNavigationBarHidden = true
        firstNameTextField.delegate = self
               lastNameTextField.delegate = self
               emailTextField.delegate = self
               passwordTextField.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(label)
        view.addSubview(createlabel)
        view.addSubview(containlabel)
        view.addSubview(createAccountButton)
        view.addSubview(signInButton)
        setupConstraints()
       
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
        checkIfUserHasAccount()
//
//                let userHasAccount = checkIfUserHasAccount()
//                if userHasAccount {
//                    navigateToHomeViewController()
//                }
       
        
    }
    
    @objc private func signInButtonTapped() {
        navigateToWelcomeViewController()
        
    }
    
    @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
    @objc private func createAccountButtonTapped() {
        print("Create button tapped")
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(title: "Empty Fields", message: "Please fill in email and password.")
            return
        }
        
        // Perform Firebase authentication to create a new user account
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
                guard let self = self else { return }

                if let error = error {
                    // Handle error
                    print("Account creation failed with error: \(error.localizedDescription)")
                    self.showAlert(title: "Error", message: "Account creation failed. \(error.localizedDescription)")
                } else if let user = authResult?.user {
                    // Account created successfully, user is now signed in
                    print("User created successfully with userID: \(user.uid)")

                    // Create a User object
                    let currentUser = User(uid: user.uid, firstName: self.firstNameTextField.text ?? "", lastName: self.lastNameTextField.text ?? "", email: user.email ?? "")

                    // Update Firebase Realtime Database or Firestore with additional user data if needed

                    // Store the user information in UserDefaults
                    UserDefaults.standard.set(user.uid, forKey: "userID")
                    UserDefaults.standard.set(currentUser.toDictionary(), forKey: "currentUser")

                    // Update the ProfileSectionHeaderView with the current user
                    self.profileSectionHeaderView.currentUser = currentUser
                    

                    // Navigate to the home screen
                    self.navigateToHomeViewController()
                    self.resetTextFields()
                }
            }
    }

    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    private func isPasswordValid(_ password: String) -> Bool {
        // Add your password validation logic here
        // For example, check if the password has at least 8 characters, includes both lower and upper case, and has at least one number or symbol
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d|[!@#$%^&*()-_=+{};:,<.>?/~`])\\S{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }

   
    
    private func navigateToHomeViewController() {
        let homeViewController = TabbarViewController() // replace with your actual HomeViewController
        navigationController?.setViewControllers([homeViewController], animated: true)
    }

    



   
    private func checkIfUserHasAccount() {
        if let userID = UserDefaults.standard.string(forKey: "userID"),
           let userDict = UserDefaults.standard.dictionary(forKey: "currentUser"),
           let firstName = userDict["firstName"] as? String,
           let lastName = userDict["lastName"] as? String,
           let email = userDict["email"] as? String {

            // All required values are available, create a User instance
            let user = User(uid: userID, firstName: firstName, lastName: lastName, email: email)

            // User is logged in, update the ProfileSectionHeaderView
            profileSectionHeaderView.currentUser = user
         

            // Navigate to the home screen
            navigateToHomeViewController()
        } else {
            // User information is not available, clear data or handle accordingly
            clearUserData()
        }
    }



    private func fetchUserByID(userID: String) -> NSManagedObject? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        // Fetch the user with the specified userID
        fetchRequest.predicate = NSPredicate(format: "userID == %@", userID)

        do {
            let users = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            return users.first
        } catch {
            print("Error fetching user by ID: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func clearUserData() {
        UserDefaults.standard.removeObject(forKey: "userID")
        // Add any other user-related data clearing logic if needed
    }
    
  

    private func navigateToWelcomeViewController() {
        let welcomeViewController = WelcomBackViewController()
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
   
    private func setupConstraints() {
        // Create a vertical stack view for the labels
        let labelsStackView = UIStackView(arrangedSubviews: [label, createlabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 5
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a vertical stack view for the text fields
        let textFieldsStackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField, passwordTextField])
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = 10
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a vertical stack view for the labels and text fields
        let mainStackView = UIStackView(arrangedSubviews: [labelsStackView, textFieldsStackView, containlabel, createAccountButton])
        mainStackView.axis = .vertical
        mainStackView.spacing = 30
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the main stack view to the view
        view.addSubview(mainStackView)
        
        // Set constraints for the main stack view
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
               lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
               emailTextField.heightAnchor.constraint(equalToConstant: 50),
               passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            signInButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func resetTextFields() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }

  
        
    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
}
