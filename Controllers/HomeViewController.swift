//
//  HomeViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 10/12/2023.
//

import UIKit
import CoreData
import PanModal
import UserNotifications





enum Sections: Int, CaseIterable {
  case home = 0
    case WorkoutSummary = 1
    case Title = 2
    case Beginner = 3
    case Advanced = 4
}


class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate, UNUserNotificationCenterDelegate{
    var videoTrackingInfoArray: [VideoTrackingEntity] = []
   
    var latestReceivedMessage: String?
    
    var notificationCount: Int = 0
    var selectedExercises: Set<String> = Set()
        
    private var selectedButton: UIButton?
    var excerise: [Exercise] = []
    var exerise: [Exercises] = []
    var combinedData: [Exercises] = []
    var combined : [Exercises] = []
    var com : [Exercises] = []
    var exceriseModel: [ExerciseTranslation] = []
    
    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.backgroundColor = .systemGray5
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        if title == selectedCategory {
               button.backgroundColor = .green
           }
        return button
    }
  
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return HomeViewController.createSectionLayout(section: sectionIndex)
        
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scheduleDailyNotification()
     
        
        UNUserNotificationCenter.current().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(_:)), name: Notification.Name("DidReceiveNotification"), object: nil)

      
        let bellButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(bellButtonTapped))
          
        let personButton = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(personButtonTapped))
        personButton.tintColor = .black
        navigationItem.rightBarButtonItems = [bellButton, personButton]
        
       
        
       updateUI()
        fetchData()
        updateBellButtonBadge()
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
        title = "Home"
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(WorkoutCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutCollectionViewCell.identifier)
        collectionView.register(NewWorkoutCollectionViewCell.self, forCellWithReuseIdentifier: NewWorkoutCollectionViewCell.identifier)
        collectionView.register(ExerciseCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseCollectionViewCell.identifier)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifer)
       collectionView.register(ActivitiesCollectionViewCell.self, forCellWithReuseIdentifier: ActivitiesCollectionViewCell.identifier)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        let buttonCell = ButtonCollectionViewCell()
        buttonCell.configure(with: [
            createButton(title: "All Types", action: #selector(AlltypeButtonTapped)),
            createButton(title: "Shoulders", action: #selector(shoulderButtonTapped)),
            createButton(title: "Arms", action: #selector(armButtonTapped)),
            createButton(title: "Cardio", action: #selector(cardioButtonTapped)),
            createButton(title: "Chest", action: #selector(chestButtonTapped))
        ]) { selectedCategory in
            self.selectedCategory = selectedCategory
            self.updateUI()
            
        }

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          
        ])
        let totalProgress = getTotalProgressForAllExerciseTypes()
        print("Total Progress for All Exercise Types: \(totalProgress)%")
        
        
        
    }
    
    @objc private func didReceiveNotification(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            // Update the latestReceivedMessage property
            latestReceivedMessage = message

            // Handle the notification in HomeViewController if needed
            // For example, update UI, show a badge, etc.
            
            // Increment the notification count
            notificationCount += 1

            // Update the badge
            updateBellButtonBadge()

            // Print the latestReceivedMessage
            // print("Latest Received Message: \(latestReceivedMessage ?? "No message")")
        }
    }

    func scheduleDailyNotification() {
          // Create a notification content
          let content = UNMutableNotificationContent()
          content.title = "Time for a workout!"
          content.body = "Get ready for your daily workout session."
          content.sound = UNNotificationSound.default
          
          // Set the notification trigger for a daily schedule
          var dateComponents = DateComponents()
          dateComponents.hour = 8 // Set the hour you want the notification
          dateComponents.minute = 0
          let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
          
          // Create a notification request
          let request = UNNotificationRequest(identifier: "dailyWorkoutNotification", content: content, trigger: trigger)
          
          // Add the notification request to the UNUserNotificationCenter
          UNUserNotificationCenter.current().add(request) { error in
              if let error = error {
                  print("Error scheduling notification: \(error.localizedDescription)")
              } else {
                  print("Daily workout notification scheduled successfully.")
              }
          }
      }


   

    
    
    var selectedCategory: String?
    
    @objc private func shoulderButtonTapped() {
        selectedCategory = "Shoulder"
        updateUI()
      
    }

    @objc private func armButtonTapped() {
        selectedCategory = "Arms"
               updateUI()
       
       
    }
    @objc private func AlltypeButtonTapped () {
        selectedCategory = "All type"
               updateUI()
        
    }
    @objc private func cardioButtonTapped () {
        selectedCategory = "Cardio"
               updateUI()
       
        
    }
    
    @objc private func chestButtonTapped () {
        selectedCategory = "Chest"
               updateUI()
     
        
    }
    
    
    func getTotalSelectedExerciseCount() -> Int {
        return selectedExercises.count
    }
    
    private func updateUI() {
        switch selectedCategory {
        // Cases here should match the categories set in the button tap functions
        case "Shoulder":
            
            APICaller.shared.getShoulders { [weak self] result in
                self?.handleAPIResult(result)
               
            }
        case "Arms":
            APICaller.shared.getArms { [weak self] result in
                self?.handleAPIResult(result)
            }
        case "Cardio":
            APICaller.shared.getCardio { [weak self] result in
                self?.handleAPIResult(result)
            }
        case "Chest":
            APICaller.shared.getChest { [weak self] result in
                self?.handleAPIResult(result)
            }
        case "All type":
            APICaller.shared.getAlltypes { [weak self] result in
                self?.handleAPIResult(result)
            }
        default:
            break
        }
    }

    private var allExerciseData: [Exercises] = []

    private func handleAPIResult(_ result: Result<ExerciseData, Error>) {
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
                // Save all fetched data
                self.allExerciseData = model.exercises

                // Clear the array before updating (only for the home view)
                self.combinedData.removeAll()

                // Convert ArraySlice to Array and take only two items from the fetched data (only for the home view)
                self.combinedData = Array(model.exercises.prefix(2))

                self.collectionView.reloadData()
                
              
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    private func getData() {
        APICaller.shared.getWorkoutSummary { [weak self ] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.com = model.exercises
                    self?.collectionView.reloadData()




                }


            case .failure(let error):
                print(error.localizedDescription)
            }
        }


    }
    private func updateBellButtonBadge() {
        let bellButton = UIButton(type: .system)
        bellButton.setImage(UIImage(systemName: "bell"), for: .normal)
        bellButton.tintColor = .black
        bellButton.addTarget(self, action: #selector(bellButtonTapped), for: .touchUpInside)

        let badgeContainerView = UIView()

        // Check if there are notifications to show the badge
        if notificationCount > 0 {
            badgeContainerView.backgroundColor = UIColor.red.withAlphaComponent(0.8)
            badgeContainerView.layer.cornerRadius = 8 // Adjust the corner radius as needed

            let badgeLabel = UILabel()
            badgeLabel.text = "\(notificationCount)"
            badgeLabel.textColor = .white
            badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)

            badgeContainerView.addSubview(badgeLabel)

            // Constrain the badge label size
            badgeLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                badgeLabel.centerXAnchor.constraint(equalTo: badgeContainerView.centerXAnchor),
                badgeLabel.centerYAnchor.constraint(equalTo: badgeContainerView.centerYAnchor),
                badgeLabel.topAnchor.constraint(equalTo: badgeContainerView.topAnchor),
                badgeLabel.bottomAnchor.constraint(equalTo: badgeContainerView.bottomAnchor),
                badgeLabel.leadingAnchor.constraint(equalTo: badgeContainerView.leadingAnchor, constant: 4),
                badgeLabel.trailingAnchor.constraint(equalTo: badgeContainerView.trailingAnchor, constant: -4)
            ])
        }

        let stackView = UIStackView(arrangedSubviews: [bellButton, badgeContainerView].compactMap { $0 })
        stackView.alignment = .center
        stackView.spacing = -5  // Adjust the spacing as needed

        let customBarButton = UIBarButtonItem(customView: stackView)

        navigationItem.rightBarButtonItem = customBarButton
    }


    
    
    @objc private func bellButtonTapped() {
        // Use the latest received message or set a default message if it's nil
        let notificationMessage = latestReceivedMessage ?? "No Notifications\n Nototifications will appear here when you receive them"

        // Print debug information
        print("Notification Message to be passed: \(notificationMessage)")

        // Instantiate and configure NotificationViewController
        let notificationViewController = NotificationViewController()
        notificationViewController.notificationMessage = notificationMessage

        // Print debug information
        print("NotificationViewController instantiated with message: \(notificationViewController.notificationMessage)")

        // Check if navigationController is not nil
        if let navigationController = navigationController {
            // Push the NotificationViewController onto the navigation stack
            navigationController.pushViewController(notificationViewController, animated: true)
        } else {
            // If navigationController is nil, present modally
            present(notificationViewController, animated: true, completion: nil)
        }
    }
    @objc private func personButtonTapped() {
        let vc = AccountViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    

    public func navigateToItemList() {
        guard let selectedCategory = selectedCategory else { return }

        // Instantiate the new view controller that displays the list of items
        let itemListViewController = PanelViewController(combinedData: allExerciseData)

        // Use PanModal to present the view controller as a bottom sheet
        presentPanModal(itemListViewController)
    }
    func updateCollectionViewData() {
        let newData = ftchData()  // Replace with your actual data fetching logic
        videoTrackingInfoArray = newData

        // Reload the collectionView after updating the data
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func ftchData() -> [VideoTrackingEntity] {
        // Replace this with your actual data fetching logic
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)
        return videoTrackingInfoArray
    }


  
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            // Show notifications even when the app is in the foreground
            completionHandler([.alert, .sound, .badge])
        }
   
    
    private func fetchData() {
        APICaller.shared.fetchExerciseList { [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.excerise = model.results
                    self?.collectionView.reloadData()
                   
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        APICaller.shared.getExerciseData { [weak self] result in
            switch result {
            case.success(let exce):
                DispatchQueue.main.async {
                    self?.combinedData = exce.exercises
                    self?.collectionView.reloadData()
                    print(exce.exercises)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        APICaller.shared.getArms { [weak self]  result in
            switch result {
            case.success(let get):
                DispatchQueue.main.async {
                    self?.exerise = get.exercises
                    self?.collectionView.reloadData()
                }
               
                
            case .failure(let error):
                print(error)
            }
        }
       
    }
    func getVideoTrackingInfo(for date: Date) -> [VideoTrackingEntity] {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let fetchRequest: NSFetchRequest<VideoTrackingEntity> = NSFetchRequest<VideoTrackingEntity>(entityName: "VideoTrackingEntity")

            fetchRequest.predicate = NSPredicate(format: "dateWatched >= %@ AND dateWatched < %@", startOfDay as NSDate, endOfDay as NSDate)

            do {
                let videoTrackingArray = try context.fetch(fetchRequest)
                return videoTrackingArray
            } catch {
                print("Error fetching video tracking information: \(error.localizedDescription)")
                return []
            }
        }
    
    
    func getTotalCaloriesForToday() -> Double {
            let currentDate = Date()
            let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

            if !videoTrackingInfoArray.isEmpty {
                var totalCalories = 0.0

                for videoTrackingInfo in videoTrackingInfoArray {
                    // Sum up the calories burned for each video
                    totalCalories += videoTrackingInfo.caloriesBurned
                }
              
             
                print("Total Calories Burned for Today: \(totalCalories)")
                return totalCalories
            } else {
                print("No video tracking information found for today.")
                return 0.0
            }
        }
    
   
    
    func getTotalDurationForToday() -> Double {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)
        
        if !videoTrackingInfoArray.isEmpty {
            var totalDuration = 0.0
            
            for videoTrackingInfo in videoTrackingInfoArray {
                // Sum up the calories burned for each video
                totalDuration += videoTrackingInfo.duration
            }
           
            print("Total Duration Burned for Today: \(totalDuration)")
            return totalDuration
        } else {
            print("No video tracking information found for today.")
            return 0.0
        }
    }
    func getTotalProgressForAllExerciseTypes() -> Int {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

        if !videoTrackingInfoArray.isEmpty {
            var completedExercises = Set<String>()

            for videoTrackingInfo in videoTrackingInfoArray {
                // Assuming each exercise has a unique identifier
                completedExercises.insert(videoTrackingInfo.videofilename)
            }

            let totalExerciseCount = 25 // Assuming you have 5 exercises for each type
            let completedExerciseCount = completedExercises.count
           
            

            // Calculate the progress as a percentage of completed exercises
            let totalProgress: Int = Int((Double(completedExerciseCount) / Double(totalExerciseCount)) * 100)
            print("Total Progress for All Exercise Types: \(totalProgress)%")
            return totalProgress
        } else {
            print("No video tracking information found for today.")
            return 0
        }
    }
    


    func getTotalHeartRateForToday() -> Int {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

        if !videoTrackingInfoArray.isEmpty {
            var totalHeartRate = 0

            for videoTrackingInfo in videoTrackingInfoArray {
                // Sum up the heart rates for each video
                totalHeartRate += Int(videoTrackingInfo.heartRate)
            }
            
            print("Total Heart Rate for Today: \(totalHeartRate)")
            return totalHeartRate
        } else {
            print("No video tracking information found for today.")
            return 0
        }
    }
    
    
   
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 10, trailing: 10)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
          
            
            
            
            return section
      
      
        case 1:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(0.7))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 2, trailing: 2)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
            
            
            
            
            return section
        case 2:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(0.7))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 2, trailing: 2)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(55)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
            
            
            
            
            return section
        case 3:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 10, trailing: 10)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            
            
            
            return section

         
       
        case 4:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
               item .contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 2)
               let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
               let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)), repeatingSubitem: verticalGroup, count: 2)
               let section = NSCollectionLayoutSection(group: horizontalGroup)
               section.orthogonalScrollingBehavior = .groupPaging
               section.boundarySupplementaryItems = supplementaryViews

               return section
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), repeatingSubitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            
            return section
                      
        }
    }
    
    

  

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
       
      
        case 3:
            // print("Advanced Section")
            //print("Translation Exercises Count: \(translationExercises.count)")
            return combinedData.count
        case 4:
            return exerise.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
           
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivitiesCollectionViewCell.identifier, for: indexPath) as? ActivitiesCollectionViewCell else {
                return UICollectionViewCell()
                
            }
            let workoutTitle = "Workout"
            let activitiesTitle = "Today's Activities"
            let totalCalories = String(getTotalCaloriesForToday()) + " kcal";
            let totalHeartRate = String(getTotalHeartRateForToday()) + " bpm";
            let totalDuration = String(getTotalDurationForToday()) + " mins";

            let totalProgress = getTotalProgressForAllExerciseTypes()
           
            cell.configure(progress: totalProgress, workoutTitle: workoutTitle, activitiesTitle: activitiesTitle, calories: totalCalories, heartRate: totalHeartRate, time: totalDuration)
           
           
            
            return cell

        case 1:
          
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as! TitleCollectionViewCell
            cell.configure()
            return cell
            
            
        case 2:
            // ButtonCollectionViewCell
            guard let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as? ButtonCollectionViewCell else {
                fatalError("Unable to dequeue ButtonCollectionViewCell")
            }
            buttonCell.configure(with: [
                createButton(title: "All Types", action: #selector(AlltypeButtonTapped)),
                createButton(title: "Shoulders", action: #selector(shoulderButtonTapped)),
                createButton(title: "Arms", action: #selector(armButtonTapped)),
                createButton(title: "Cardio", action: #selector(cardioButtonTapped)),
                createButton(title: "Chest", action: #selector(chestButtonTapped))
            ]) { selectedCategory in
                self.selectedCategory = selectedCategory
                self.updateUI()
            }
            return buttonCell
       
      
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewWorkoutCollectionViewCell.identifier, for: indexPath) as? NewWorkoutCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = combinedData[indexPath.row]
            cell.configure(viewModel: viewModel )
            // print("Configuring Advanced Cell: \(indexPath.row)")
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExerciseCollectionViewCell.identifier, for: indexPath) as? ExerciseCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = exerise[indexPath.row]
            cell.configure(viewModel: viewModel )
            // print("Configuring Advanced Cell: \(indexPath.row)")
            return cell
            
            
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifer, for: indexPath) as? TitleHeaderCollectionReusableView,
            kind == UICollectionView.elementKindSectionHeader,
            let sectionEnum = Sections(rawValue: indexPath.section)
        else {
            return UICollectionReusableView()
        }

        switch sectionEnum {
        case .Title:
            ""
        case .WorkoutSummary:
            ""
        case .home:
            ""
        case .Beginner:
            header.configure(with: "Beginner Level")
        case .Advanced:
            header.configure(with: "Advanced Level")
       
       
        }

        return header
    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        
        switch section {
        case Sections.Advanced.rawValue:
            let selectedExercise = combinedData[indexPath.row]
            navigateToExerciseDetails(exercise: selectedExercise, combinedData: selectedExercise)
        case Sections.Beginner.rawValue:
            let selectedExercise = combinedData[indexPath.row]
            navigateToExerciseDetails(exercise: selectedExercise, combinedData: selectedExercise)
        default:
            break
        }
    }
    
    
    private func navigateToExerciseDetails(exercise: Exercises, combinedData: Exercises) {
        guard let selectedCategory = selectedCategory else {
            // Handle the case when selectedCategory is nil
            print("Selected category is nil.")
            return
        }

        let exerciseDetailsViewController = HomeDetailViewController(exercise: [exercise], combinedData: [combinedData], selectedCategory: selectedCategory)

        navigationController?.pushViewController(exerciseDetailsViewController, animated: true)
        navigationItem.largeTitleDisplayMode = .never
    }
    
}
