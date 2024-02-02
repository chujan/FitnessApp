//
//  TabbarViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 10/12/2023.
//

import UIKit

class TabbarViewController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        view.backgroundColor = .systemBackground
    }
    
    private func setUpTabs() {
        tabBar.tintColor = .black
        let HomeVC = HomeViewController()
        let programVC = ProgramViewController()
        let progressVC = ProgressViewController()
       
        let goalVC = GoalViewController()
        
        HomeVC.navigationItem.largeTitleDisplayMode = .automatic
        programVC.navigationItem.largeTitleDisplayMode = .automatic
        progressVC.navigationItem.largeTitleDisplayMode = .automatic
     
        goalVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: HomeVC)
        let nav2 = UINavigationController(rootViewController: programVC)
        let nav3 = UINavigationController(rootViewController: progressVC)
       
        let nav4 = UINavigationController(rootViewController: goalVC)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Program", image: UIImage(systemName: "bolt.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "homepodmini.fill"), tag: 3)
      
        nav4.tabBarItem = UITabBarItem(title: "Nutrition", image: UIImage(systemName: "carrot"), tag: 5)
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
          
        }
        setViewControllers([nav1, nav2, nav3,nav4], animated: true)
    }
    

  
}
