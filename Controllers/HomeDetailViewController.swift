//
//  HomeDetailViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 29/12/2023.
//

import UIKit
import Foundation
import CoreData

@objc(VideoTrackingEntity)
public class VideoTrackingEntity: NSManagedObject {

    @NSManaged public var videoID: String
    @NSManaged public var caloriesBurned: Double
    @NSManaged public var heartRate: Int16
    @NSManaged public var duration: Double
    @NSManaged public var dateWatched: Date
    @NSManaged public var videofilename: String
    @NSManaged public var type: String
    @NSManaged public var progress: Int16
    @NSManaged public var isCompleted: Bool
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    
   

}



class HomeDetailViewController: UIViewController, UNUserNotificationCenterDelegate {
    
   
   
    
    var exercise : [Exercises] = []
    var combinedData : [Exercises] = []
    var com : [Exercises] = []
    var selectedCategory: String?
 

    
    private var lastContentOffset: CGFloat = 0
    var initialContentOffset: CGFloat = 0
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return HomeDetailViewController.createSectionLayout(section: sectionIndex)
        
    })
   

        // Update the initializer to accept an Exercises parameter
    init(exercise: [Exercises], combinedData: [Exercises], selectedCategory: String?) {
            self.exercise = exercise
            self.selectedCategory = selectedCategory
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        tabBarController?.tabBar.isHidden = false
                // or adjust its appearance
                tabBarController?.tabBar.isTranslucent = false
          
      
      
      
        let totalShouldersCalories = getTotalCaloriesForType(type: "Shoulders")
        print("Total Shoulders Calories for Today: \(totalShouldersCalories)")
       

        let totalCaloriesForToday = getTotalCaloriesForToday()
           print("Total Calories for Today: \(totalCaloriesForToday)")
        let totalHeartRateForToday = getTotalHeartRateForToday()
            print("Total Heart Rate for Today: \(totalHeartRateForToday)")
        let totalDurationForToday = getTotalDurationForToday()
        print("Total Duration Burned for Today: \(totalDurationForToday)")
      
      

       
        title = "Workout Detail"
        fetchData()
      

        if let navigationController = navigationController {
                let topInset = navigationController.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
                collectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            }

        collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.isDirectionalLockEnabled = true
                collectionView.alwaysBounceVertical = true
            
       
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(photoCollectionViewCell.self, forCellWithReuseIdentifier: photoCollectionViewCell.identifier)
       
        collectionView.register(StatisticsCollectionViewCell.self, forCellWithReuseIdentifier: StatisticsCollectionViewCell.identifier)

        collectionView.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: DescriptionCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellIdentifier")

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(KcalCollectionViewCell.self, forCellWithReuseIdentifier: KcalCollectionViewCell.identifier)
        collectionView.register(BmpCollectionViewCell.self, forCellWithReuseIdentifier: BmpCollectionViewCell.identifier)

        view.addSubview(collectionView)
        
        

      
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
      
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let message = notification.request.content.body
                NotificationCenter.default.post(name: Notification.Name("DidReceiveNotification"), object: nil, userInfo: ["message": message])

            let alertController = UIAlertController(title: notification.request.content.title, message: notification.request.content.body, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)

            // Call the completion handler to display the notification
            completionHandler([.alert, .sound])
        }
    
    func scheduleWorkoutNotification(videoID: String, caloriesBurned: Double, duration: TimeInterval) {
        let center = UNUserNotificationCenter.current()

        // Create a notification content
        let content = UNMutableNotificationContent()
        content.title = "Workout Completed!"
        content.body = String(format: "You burned %.2f calories in %.2f minutes. Great job!", caloriesBurned, duration / 60.0)
        content.sound = UNNotificationSound.default

        // Set the trigger for the notification (you can customize this based on your requirements)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // Create a notification request
        let request = UNNotificationRequest(identifier: videoID, content: content, trigger: trigger)

        // Schedule the notification
        center.add(request) { error in
            if let error = error {
                print("Error scheduling workout notification: \(error.localizedDescription)")
            } else {
                print("Workout notification scheduled successfully")
            }
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
    
    

    
    
    
    
    func saveVideoTrackingInfo(for exercise: Exercises) {
        guard let videoFileName = exercise.videoFileName,
              let caloriesBurned = exercise.caloriesBurned else {
            print("Error: Missing required data for saving video tracking information.")
            return
        }
        print("exer\(caloriesBurned)")

        // Use the nil-coalescing operator to handle optional values safely
        let heartRate = exercise.averageHeartRate ?? 0

        // Use nil-coalescing and convert the duration to Double
        let duration = Double(exercise.durationMinutes ?? 0)
        let type = exercise.type ?? ""
        let startTime = Date()
        let endTime = Date()

        // Call the saveVideoTrackingInfo method with the obtained values
        saveVideoTrackingInfo(videoID: videoFileName, videofilename: videoFileName, calories: caloriesBurned, heartRate: Int(heartRate), duration: duration, type: type, startTime: startTime, endTime: endTime)
    }
    

    
    func saveVideoTrackingInfo(videoID: String, videofilename: String, calories: Double, heartRate: Int, duration: TimeInterval, type: String, startTime: Date?, endTime: Date?) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let videoTrackingInfo = VideoTrackingEntity(context: context)
      
        
        videoTrackingInfo.videoID = videoID
        videoTrackingInfo.caloriesBurned = calories
        videoTrackingInfo.heartRate = Int16(heartRate)
        videoTrackingInfo.duration = duration
        videoTrackingInfo.dateWatched = Date()
        videoTrackingInfo.videofilename = videofilename
        videoTrackingInfo.type = type
        videoTrackingInfo.startTime = startTime
        scheduleWorkoutNotification(videoID: videoID, caloriesBurned: calories, duration: duration)

        // Calculate endTime based on startTime and duration
        if let startTime = videoTrackingInfo.startTime {
            videoTrackingInfo.endTime = startTime.addingTimeInterval(duration)
        }

        do {
            try context.save()
            
            // Print the saved video tracking information
            print("Video tracking information saved successfully:")
            print("Video ID: \(videoTrackingInfo.videoID)")
            print("Calories Burned: \(videoTrackingInfo.caloriesBurned)")
            print("Heart Rate: \(videoTrackingInfo.heartRate)")
            print("Duration: \(videoTrackingInfo.duration)")
            print("Date Watched: \(videoTrackingInfo.dateWatched)")
            print("Videofilename: \(videoTrackingInfo.videofilename)")
            print("Type: \(videoTrackingInfo.type)")
            print("Start Time: \(videoTrackingInfo.startTime)")

            // Use optional binding to print endTime if it's provided
            if let endTime = videoTrackingInfo.endTime {
                print("End Time: \(endTime)")
            } else {
                print("End Time: N/A")
            }
        } catch {
            print("Error saving video tracking information: \(error.localizedDescription)")
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
    
    
    

    
    private func fetchData() {
        APICaller.shared.getAlltypes { [weak self] result in
            switch result {
            case.success(let model):
                self?.combinedData = model.exercises
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APICaller.shared.getAlltypes { [weak self] result in
            switch result {
            case.success(let viewmodel):
                self?.com = viewmodel.exercises
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
   

    func getTotalCaloriesForType(type: String) -> Double {
        let filteredVideos = exercise.filter { $0.type == type && Calendar.current.isDateInToday($0.startDate ?? Date()) }
        let totalCalories = filteredVideos.reduce(0.0) { total, video in
            if let caloriesBurned = video.caloriesBurned {
                return total + caloriesBurned
            } else {
                return total
            }
        }
        return totalCalories
    }
    // Inside HomeDetailViewController
  
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        switch section {
      
      
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
          
            
        return section
            
         
        case 1:
          
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 0)

            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(130)), subitems: [item])
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(140)), subitems: [verticalGroup])

            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        case 2:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            )
            // Use a negative bottom inset to offset the content upwards
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 10)

            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(700)),
                subitems: [item]
            )

            let section = NSCollectionLayoutSection(group: group)
            //section.orthogonalScrollingBehavior = .groupPaging // Adjust the scrolling behavior
            return section
           
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)), repeatingSubitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
          
            
            return section
                      
        }
    }
    
    
    
    
}

extension HomeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return exercise.count
        case 1:
            return 4
            case 2:
            return  exercise.count
      
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCollectionViewCell.identifier, for: indexPath) as? photoCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = exercise[indexPath.row]
            cell.configure(viewModel: viewModel)
            return cell

        
        case 1:
            let cell: UICollectionViewCell

            if indexPath.item == 0 {
                print("Debug: kcal count is \(exercise.count)")
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: KcalCollectionViewCell.identifier, for: indexPath) as? KcalCollectionViewCell ?? UICollectionViewCell()
                (cell as? KcalCollectionViewCell)?.configure(exercise: exercise[indexPath.row])
                
            } else if indexPath.item == 1 {
                
                print("Debug: combinedData count is \(combinedData.count)")

                if indexPath.row < combinedData.count {
                    print("Debug: indexPath.row is within the valid range for combinedData")
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: BmpCollectionViewCell.identifier, for: indexPath) as? BmpCollectionViewCell ?? UICollectionViewCell()
                    (cell as? BmpCollectionViewCell)?.configure(exercise: combinedData[indexPath.row])
                } else {
                    print("Debug: indexPath.row is out of range for combinedData")
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellIdentifier", for: indexPath) // Assign a generic reuse identifier
                }
            } else if indexPath.item == 2 {
             
                print("Debug: com count is \(com.count)")

                if indexPath.row < com.count {
                    print("Debug: indexPath.row is within the valid range for com")
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionViewCell.identifier, for: indexPath) as? StatisticsCollectionViewCell ?? UICollectionViewCell()
                    (cell as? StatisticsCollectionViewCell)?.configure(exercise: com[indexPath.row])
                } else {
                    print("Debug: indexPath.row is out of range for com")
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellIdentifier", for: indexPath) // Assign a generic reuse identifier
                }
            } else {
                print("Debug: indexPath.item is \(indexPath.item), using default UICollectionViewCell")
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellIdentifier", for: indexPath) // Assign a generic reuse identifier
            }

            print("Debug: returning cell")
            return cell


        case 2:
            // Similar to the existing code for section 0
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCollectionViewCell.identifier, for: indexPath) as? DescriptionCollectionViewCell else {
                return UICollectionViewCell()
            }

            let viewModel = exercise[indexPath.row]
            cell.startButtonTappedHandler = { [weak self] in
                // Handle the button tap here
                // You can perform navigation or any other action
                if let selectedIndexPath = self?.collectionView.indexPath(for: cell) {
                    let selectedExercise = self?.exercise[selectedIndexPath.row]
                    let videoURLString = selectedExercise?.videoURL

                    // Check if the exercise has a valid video URL
                    if let videoURLString = videoURLString, let videoURL = URL(string: videoURLString) {
                        // Check if the video file exists in the app's bundle
                        if let bundleVideoURL = Bundle.main.url(forResource: selectedExercise?.videoFileName, withExtension: "mp4") {
                            // Save video tracking info before navigating to the video view controller
                            guard let videoFileName = selectedExercise?.videoFileName,
                                  let caloriesBurned = selectedExercise?.caloriesBurned else {
                                print("Error: Missing required data for saving video tracking information.")
                                return
                            }

                            // Add your heart rate logic here, assuming your Exercises model has a property named heartRate
                            let heartRate = selectedExercise?.averageHeartRate ?? 0

                            // Add your duration logic here, assuming your Exercises model has a property named duration
                            let duration = selectedExercise?.durationMinutes ?? Int(0.0)
                            let type = selectedExercise?.type
                            let startTime = Date()
                            let endTime = Date()

                            self?.saveVideoTrackingInfo(videoID: videoFileName, videofilename: selectedExercise?.videoFileName ?? "", calories: caloriesBurned, heartRate: Int(heartRate), duration: TimeInterval(duration), type: type!, startTime: startTime, endTime: endTime)


                            let videoViewController = VideoViewController(videoURL: bundleVideoURL)
                            self?.navigationController?.pushViewController(videoViewController, animated: true)
                        } else {
                            print("Error: Video file not found.")
                        }
                    } else {
                        print("Error: Video URL is not available.")
                    }
                }
            }

            cell.configure(viewModel: viewModel)
            return cell

        default:
            return UICollectionViewCell()
        }
        
    }

//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//          initialContentOffset = scrollView.contentOffset.y
//      }

//      func scrollViewDidScroll(_ scrollView: UIScrollView) {
//          guard let collectionView = scrollView as? UICollectionView else {
//              return
//          }
//
//          let currentOffset = scrollView.contentOffset.y
//
//          // Allow free upward scrolling
//          if currentOffset < 0 {
//              return
//          }
//
//          // Check if the scrolling direction is upward (contentOffset.y is decreasing)
//          if currentOffset < lastContentOffset {
//              // Allow the user to freely move the content upward until the initial content offset
//              let newY = max(initialContentOffset, currentOffset)
//              collectionView.setContentOffset(CGPoint(x: 0, y: newY), animated: false)
//          }
//
//          lastContentOffset = currentOffset
//      }
    }






       

