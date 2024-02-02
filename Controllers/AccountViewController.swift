//
//  AccountViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 10/12/2023.
//

//
//  AccountViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 10/12/2023.
//

import UIKit
import CoreData
import FirebaseAuth
import Firebase




class AccountViewController: UIViewController {
    var currentUser: User?
    
    var latestReceivedMessage: String?
    private var profileHeaderView: ProfileSectionHeaderView?
    private let accountTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.layer.masksToBounds = true
        imageView.tintColor = UIColor.systemGray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let changePictureButton: UIButton = {
           let button = UIButton()
           // Use the camera system symbol for the button image
           let cameraImage = UIImage(systemName: "camera")
           button.setImage(cameraImage, for: .normal)
           button.tintColor = .blue
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .none
        profileHeaderView = ProfileSectionHeaderView(reuseIdentifier: ProfileSectionHeaderView.identifier)
        profileHeaderView?.commonInit()
       // profileHeaderView?.profileImageView = profileImageView
          profileHeaderView?.currentUser = currentUser
        if UserDefaults.standard.string(forKey: "userName") != nil {
            profileHeaderView?.currentUser = currentUser
            profileHeaderView?.commonInit()
                  
               }
       
       
        
      
     
        accountTableView.tableHeaderView = profileHeaderView
        
        accountTableView.reloadData()
        
        title = "Profile"
        view.backgroundColor = .systemBackground
        accountTableView.separatorStyle = .singleLine
      
        // Set the delegate and dataSource before registering cells
        accountTableView.delegate = self
        accountTableView.dataSource = self
      
     
        
       
        accountTableView.register(ProfileSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileSectionHeaderView.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(_:)), name: Notification.Name("DidReceiveNotification"), object: nil)

        
       
        accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        accountTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        accountTableView.register(FocusTableViewCell.self, forCellReuseIdentifier: FocusTableViewCell.identifier)
        accountTableView.register(ProfleSetting.self, forCellReuseIdentifier: ProfleSetting.identifier)
        accountTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.identifier)
        accountTableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: LogOutTableViewCell.identifier)
        view.addSubview(accountTableView)
      

        
        // Activate constraints
        NSLayoutConstraint.activate([
            accountTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
       
    }
   

   

     


    @objc private func didReceiveNotification(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            // Update the latestReceivedMessage property
            latestReceivedMessage = message
        }
    }

    private func performLogout() {
           // Implement your logout logic here
           // For example, you can show an alert to confirm the logout
           let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { [weak self] (_) in
               // Implement actual logout logic, e.g., clear user session, navigate to login screen, etc.
               self?.logout()
           }

           alertController.addAction(cancelAction)
           alertController.addAction(logoutAction)

           present(alertController, animated: true, completion: nil)
       }
    private func logout() {
        // Clear user-related data

        // Clear data from UserDefaults
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.removeObject(forKey: "currentUser")

        // Sign out from Firebase
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Error signing out: \(error.localizedDescription)")
        }

        // Create a new instance of LoginViewController
        let loginViewController = LoginViewController()

        // Set LoginViewController as the root view controller
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    


    

               
            
}


extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
    }
   
   

       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                // Dequeue and configure the first type of cell for section 0
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else {
                    return UITableViewCell()
                }

              let image = UIImage(systemName: "gauage.high")
                let label  = "My stats"
                cell.configure(image: image, calories: label)

                  
                

                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FocusTableViewCell.identifier, for: indexPath) as? FocusTableViewCell else {
                    return UITableViewCell()
                }
                
                let image = UIImage(systemName: "star")
                  let label  = "My goals"
                  cell.configure(image: image, calories: label)

              

                return cell
            }
        case 1:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfleSetting.identifier, for: indexPath) as? ProfleSetting else {
                    return UITableViewCell()
                }
                let image = UIImage(systemName: "person")
                  let label  = "Profile settings"
                  cell.configure(image: image, calories: label)
                
                return cell
                
            } else if indexPath.row == 1 {
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell else {
                    return UITableViewCell()
                }
                let image = UIImage(systemName: "bell")
                  let label  = "Notifications"
                  cell.configure(image: image, calories: label)
              
                
                return cell
                
            } else if indexPath.row == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: LogOutTableViewCell.identifier, for: indexPath) as? LogOutTableViewCell else {
                    return UITableViewCell()
                }
                let image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
                       let label = "Logout"
                       cell.configure(image: image, calories: label)
                return cell
                
            } else {
                return UITableViewCell()
            }
           
            // Add additional configuration as needed

        default:
            return UITableViewCell()
        }
    }

       
          
      
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section {
            case 0:
                return "General"
            case 1:
                return "Settings"
           
            default:
                return nil
            }
        }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileSectionHeaderView.identifier) as! ProfileSectionHeaderView
            headerView.profileImageView = profileImageView
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 40 // Set the height for the first section's header
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let myStatVC = ProgressViewController()
                navigationController?.pushViewController(myStatVC, animated: true)
            } else if indexPath.row == 1 {
                let myGoal = GoalViewController()
                navigationController?.pushViewController(myGoal, animated: true)
            }
        case 1:
            if indexPath.row == 0 {
                let profileVC = ProfileViewController()
                navigationController?.pushViewController(profileVC, animated: true)
            } else if indexPath.row == 1 {
                let notificationVC = NotificationViewController()
                
                // Use the latest received message or set a default message if it's nil
                let notificationMessage = latestReceivedMessage ?? "No Notifications\n Nototifications will appear here when you receive them"
                notificationVC.notificationMessage = notificationMessage

                navigationController?.pushViewController(notificationVC, animated: true)
            } else if indexPath.row == 2 {
                performLogout()
            }
        default:
            break
        }
    }

    
}


