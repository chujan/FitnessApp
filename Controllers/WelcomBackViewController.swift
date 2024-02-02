//
//  WelcomBackViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 19/01/2024.
//

import UIKit
import CoreData
import FirebaseAuth
 import SwiftKeychainWrapper


class WelcomBackViewController: UIViewController {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome Back"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    
    private let createlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " SignIn to get started"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
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
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        

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

    
    private let SignInButton: UIButton = {
           let button = UIButton(type: .system)
          button.layer.cornerRadius = 12
          button.layer.borderWidth = 1.0
           button.layer.borderColor = UIColor.white.cgColor
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Sign In", for: .normal)
           button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
           button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
           button.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
           return button
       }()
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
              button.setTitle("Dont have an Account?  Create one", for: .normal)
              button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
              button.setTitleColor(.black, for: .normal)
              button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
              return button
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome Back"
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(SignInButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(label)
        view.addSubview(createlabel)
        view.addSubview(createAccountButton)
        setUpContraint()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
        
    }
    private func navigateToWelcomeViewController() {
        let welcomeViewController = LoginViewController()
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    @objc private func signInButtonTapped() {
        navigateToWelcomeViewController()
        
    }
    
    @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
    
    
    private func setUpContraint() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createlabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            createlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: createlabel.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            SignInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 10),
            SignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            SignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            SignInButton.heightAnchor.constraint(equalToConstant: 50),
            
            createAccountButton.topAnchor.constraint(equalTo: SignInButton.bottomAnchor, constant: 10),
           createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
                 
                    forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            
                   
            
        ])
    }
   
    @objc private func SignIn() {
        print("Create button tapped")
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
             !email.isEmpty, !password.isEmpty else {
            showAlert(title: "Empty Fields", message: "Please fill in all the required fields.")
            // Show an alert or handle the case where any of the required fields are empty
            return
        }
        if !isPasswordValid(password) {
                // Show an alert for invalid password
                showAlert(title: "Invalid Password", message: "Password should contain at least 8 characters, including both upper and lower case, and at least one number or symbol.")
                return
            }

        // Perform your account creation logic
        createAccount( email: email, password: password) { success in
            if success {
                // Account created successfully, navigate to the home view controller
                self.navigateToHomeViewController()
                self.resetTextFields()
                
            } else {
               
                // Account creation failed, you may want to show an alert or handle the error
                print("Account creation failed")
            }
        }
    }
    
    @objc private func forgotPasswordButtonTapped() {
        // Assuming you have a UITextField named emailTextField where the user enters their email
        guard let email = emailTextField.text else {
            // Handle the case where the email is not provided
            return
        }

        // Call the Firebase Auth API to send a password reset email
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error as NSError? {
                print("Password reset email could not be sent: \(error.localizedDescription)")

                // Print additional error details if available
                let errorCode = error.code
                print("Error Code: \(errorCode)")

                // Handle the error, show an alert to the user, etc.
                self.showPasswordResetErrorAlert(errorMessage: error.localizedDescription)
            } else {
                // Password reset email sent successfully
                print("Password reset email sent successfully")

                // Inform the user that a password reset email has been sent
                // You might show an alert or update the UI accordingly
                self.showPasswordResetSuccessAlert()
            }
        }

    }

    private func showPasswordResetErrorAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showPasswordResetSuccessAlert() {
           let alertController = UIAlertController(title: "Success", message: "Password reset successful", preferredStyle: .alert)

           alertController.addTextField { textField in
               textField.placeholder = "New Password"
               textField.isSecureTextEntry = true
           }

           alertController.addTextField { textField in
               textField.placeholder = "Confirm Password"
               textField.isSecureTextEntry = true
           }

           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

           let changePasswordAction = UIAlertAction(title: "Change Password", style: .default) { [weak self] _ in
               guard let newPassword = alertController.textFields?.first?.text,
                     let confirmPassword = alertController.textFields?.last?.text,
                     newPassword == confirmPassword,
                     !newPassword.isEmpty else {
                   self?.showAlert(title: "Invalid Password", message: "New password and confirmation password must match and not be empty.")
                   return
               }

               // Perform your password change logic
               // You might want to use Firebase Auth API or your authentication provider's API to update the user's password

               // After successfully changing the password, you can navigate to the home screen or perform any other action
               self?.navigateToHomeViewController()
               self?.resetTextFields()
           }

           alertController.addAction(cancelAction)
           alertController.addAction(changePasswordAction)

           present(alertController, animated: true, completion: nil)
       }


  


    private func showForgotPasswordAlert() {
        let alertController = UIAlertController(title: "Forgot Password", message: "Enter your email to reset your password", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Email Address"
            textField.keyboardType = .emailAddress
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let resetPasswordAction = UIAlertAction(title: "Reset Password", style: .default) { [weak self] _ in
            guard let email = alertController.textFields?.first?.text else {
                // Handle the case where the email is nil
                return
            }

            self?.sendPasswordResetEmail(to: email)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(resetPasswordAction)

        present(alertController, animated: true, completion: nil)
    }
    
    

    private func sendPasswordResetEmail(to email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Handle the error, for example, show an alert to the user
                print("Password reset email could not be sent: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: "Password reset email could not be sent. Please try again.")
            } else {
                // Password reset email sent successfully
                // Show a success message or navigate to a screen informing the user to check their email
                print("Password reset email sent successfully")
                self.showAlert(title: "Success", message: "Password reset email sent. Please check your email to reset your password.")
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

    private func createAccount(email: String, password: String, completion: @escaping (Bool) -> Void) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                completion(false)
                return
            }

            let managedContext = appDelegate.persistentContainer.viewContext

            // Check if the user with the same email already exists
            if let existingUser = fetchUserByEmail(email: email) {
                // User already exists, use the existing userID
                let userID = existingUser.value(forKeyPath: "userID") as! String
                print("User already exists with userID: \(userID)")

                // Save userID to UserDefaults
                UserDefaults.standard.set(userID, forKey: "userID")
                // Save userID to Keychain for more secure storage
                KeychainWrapper.standard.set(userID, forKey: "userID")

                // Save user status to UserDefaults
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")

                completion(true)
            } else {
                // User doesn't exist, create a new user
                if let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext) {
                    let user = NSManagedObject(entity: entity, insertInto: managedContext)

                    // Set other user attributes
                    user.setValue(email, forKeyPath: "email")
                    user.setValue(password, forKeyPath: "password")

                    // Set the user ID using UUID
                    let userID = UUID().uuidString
                    user.setValue(userID, forKeyPath: "userID")

                    do {
                        try managedContext.save()
                        print("User created successfully with userID: \(userID)")

                        // Save userID to UserDefaults
                        UserDefaults.standard.set(userID, forKey: "userID")
                        // Save userID to Keychain for more secure storage
                        KeychainWrapper.standard.set(userID, forKey: "userID")

                        // Save user status to UserDefaults
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        if let user = fetchUserByEmail(email: email) {
                                        let userName = user.value(forKey: "name") as? String ?? ""
                                        print("User name: \(userName)")

                                        // Save user name to UserDefaults
                                        UserDefaults.standard.set(userName, forKey: "userName")
                                    }

                        completion(true)
                    } catch let error as NSError {
                        print("Could not save user. \(error), \(error.userInfo)")
                        completion(false)
                    }
                } else {
                    // Handle the case where the entity cannot be created
                    print("Error creating entity")
                    completion(false)
                }
            }
        }

    private func fetchUserByEmail(email: String) -> NSManagedObject? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")

        // Fetch the user with the specified email
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let users = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            return users.first
        } catch {
            print("Error fetching user by email: \(error.localizedDescription)")
            return nil
        }
    }

    private func resetTextFields() {
       
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    

    private func navigateToHomeViewController() {
           let homeViewController = TabbarViewController() // replace with your actual HomeViewController
           navigationController?.pushViewController(homeViewController, animated: true)
       }
    private func checkIfUserHasAccount() {
           if let isUserLoggedIn = UserDefaults.standard.value(forKey: "isUserLoggedIn") as? Bool, isUserLoggedIn {
               // User is logged in, navigate to the home screen
               navigateToHomeViewController()
           }
       }
}
