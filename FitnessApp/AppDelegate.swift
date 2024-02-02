//
//  AppDelegate.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 10/12/2023.
//

import UIKit
import Firebase
import FirebaseMessaging
import CoreData
import UserNotifications
@main


class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
       var inactivityTimer: Timer?
       let inactivityTimeInterval: TimeInterval = 300

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fitness")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // Save the context when the app is about to terminate
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                   if granted {
                       print("Notification authorization granted")
                   } else {
                       print("Notification authorization denied")
                   }
               }
        FirebaseApp.configure()

               // Schedule a sample notification 10 seconds from now
             
            return true
        }
  
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
            startInactivityTimer()
        }

        func applicationWillEnterForeground(_ application: UIApplication) {
            invalidateInactivityTimer()
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            invalidateInactivityTimer()
            checkAuthenticationState()
        }

        func startInactivityTimer() {
            inactivityTimer = Timer.scheduledTimer(timeInterval: inactivityTimeInterval, target: self, selector: #selector(logoutDueToInactivity), userInfo: nil, repeats: false)
        }

        func invalidateInactivityTimer() {
            inactivityTimer?.invalidate()
            inactivityTimer = nil
        }
    @objc func logoutDueToInactivity() {
            // Perform logout logic when the timer expires
            performLogout()
        }
    func checkAuthenticationState() {
           if Auth.auth().currentUser == nil {
               // User is not logged in, present the login screen
               showLoginScreen()
           }
       }
    func showLoginScreen() {
            // Present your login view controller here
            let loginViewController = LoginViewController()
            window?.rootViewController?.present(loginViewController, animated: true, completion: nil)
        }
    
    func performLogout() {
        // Clear user-related data
        UserDefaults.standard.removeObject(forKey: "userID")
        UserDefaults.standard.removeObject(forKey: "currentUser")

        // Sign out from Firebase
        do {
            try Auth.auth().signOut()
            
            // Show an alert to inform the user that they have been logged out
            let alertController = UIAlertController(title: "Logout Successful", message: "You have been logged out due to inactivity.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
                // After the user acknowledges the logout, navigate to the login screen
                self?.navigateToLoginViewController()
            }
            alertController.addAction(okAction)
            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        } catch let error as NSError {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func navigateToLoginViewController() {
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}
