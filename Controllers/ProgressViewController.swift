//
//  ProgressViewController.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 10/12/2023.
//

import UIKit
import HealthKit
import CoreData
struct ExerciseProgress {
    var exerciseType: String
    var progress: Int
}


class ProgressViewController: UIViewController {
   

    var getTotalCaloriesForTypeClosure: ((String) -> Double)?
    var exerciseProgressList: [ExerciseProgress] = []
    var videoTrackingInfoArray: [VideoTrackingEntity] = []
   // var caloriesArray: [getTotalCaloriesForToday] = []
   
   
    var exercise : [Exercises] = []
    var exerciseData: [Exercises] = []
    var comData: [Exercises] = []
    var combined: [Exercises] = []
    func reloadData() {
            collectionView.reloadData()
        }
   
    
  
  
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in return ProgressViewController.createSectionLayout(section: sectionIndex)
        
    })

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollectionViewData()

        
        
       
        title = "Daily Workout"
        navigationItem.largeTitleDisplayMode = .never
       
     
     

        view.addSubview(collectionView)
       // updateCollectionView()
       // uPdateCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DurationCollectionViewCell.self, forCellWithReuseIdentifier: DurationCollectionViewCell.identifier)
        collectionView.register(CaloriesCollectionViewCell.self, forCellWithReuseIdentifier: CaloriesCollectionViewCell.identifier)
        collectionView.register(HeartrateCollectionViewCell.self, forCellWithReuseIdentifier: HeartrateCollectionViewCell.identifier)
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.identifier)
        collectionView.register(WorkoutSummaryCollectionViewCell.self, forCellWithReuseIdentifier: WorkoutSummaryCollectionViewCell.identifier)
        collectionView.register(TodaysDateCollectionViewCell.self, forCellWithReuseIdentifier: TodaysDateCollectionViewCell.identifier)
        collectionView.register(SummaryCollectionViewCell.self, forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier)
     
    
      
        fetchData()
      
       
       
      
    }
   

    
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        //collectionView.reloadData()
    }
    
    
    func calculateAndReloadCollectionView() {
        // Calculate new values or perform any other necessary updates

        // Reload the collection view on the main thread
        DispatchQueue.main.async  {
            self.collectionView.reloadData()
        }
    }
    
    
    
    
    func getTotalCaloriesForExerciseType(_ exerciseType: String) -> Double {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

        if !videoTrackingInfoArray.isEmpty {
            var totalCalories = 0.0

            for videoTrackingInfo in videoTrackingInfoArray {
                // Check if the exercise type matches the specified type
                if videoTrackingInfo.type == exerciseType {
                    // Sum up the calories burned for the specified exercise type
                    totalCalories += videoTrackingInfo.caloriesBurned
                }
            }
           

            print("Total Calories Burned for \(exerciseType) today: \(totalCalories)")
            return totalCalories
        } else {
            print("No video tracking information found for today.")
            return 0.0
        }
    }
    
    func getTotalHeartRateForExerciseType(_ exerciseType: String) -> Int {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

        if !videoTrackingInfoArray.isEmpty {
            var totalHeartRate = 0

            for videoTrackingInfo in videoTrackingInfoArray {
                // Check if the exercise type matches the specified type
                if videoTrackingInfo.type == exerciseType {
                    // Sum up the calories burned for the specified exercise type
                    totalHeartRate += Int(videoTrackingInfo.heartRate)
                }
            }
          

            print("Total Calories Burned for \(exerciseType) today: \(totalHeartRate)")
            return totalHeartRate
        } else {
            print("No video tracking information found for today.")
            return 0
        }
    }
    func getTotalDurationForExerciseType(_ exerciseType: String) -> Double {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

        if !videoTrackingInfoArray.isEmpty {
            var totalDuration = 0.0

            for videoTrackingInfo in videoTrackingInfoArray {
                // Check if the exercise type matches the specified type
                if videoTrackingInfo.type == exerciseType {
                    // Sum up the calories burned for the specified exercise type
                    totalDuration += videoTrackingInfo.duration
                }
            }
           

            print("Total Calories Burned for \(exerciseType) today: \(totalDuration)")
            return totalDuration
        } else {
            print("No video tracking information found for today.")
            return 0.0
        }
    }
    
    func getProgressForExerciseType(_ exerciseType: String) -> Int {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

        if !videoTrackingInfoArray.isEmpty {
            var completedExercises = Set<String>()

            for videoTrackingInfo in videoTrackingInfoArray {
                if videoTrackingInfo.type == exerciseType {
                    // Assuming each exercise has a unique identifier
                    completedExercises.insert(videoTrackingInfo.videofilename)
                }
            }

            let totalExerciseCount = 5 // Assuming you have 5 exercises for each type
            let completedExerciseCount = completedExercises.count

            // Calculate the progress as a percentage of completed exercises
            let progress: Int = Int((Double(completedExerciseCount) / Double(totalExerciseCount)) * 100)
           

            print("Progress for \(exerciseType): \(progress)%")
            return progress
        } else {
            print("No video tracking information found for today.")
            return 0
        }
    }



    
    func getTootalCaloriesForExerciseType(_ exerciseType: String) -> Double {
        let currentDate = Date()
        let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

        if !videoTrackingInfoArray.isEmpty {
            var totalCalories = 0.0

            for videoTrackingInfo in videoTrackingInfoArray {
                // Check if the exercise type matches the specified type
                if videoTrackingInfo.type == exerciseType {
                    // Sum up the calories burned for the specified exercise type
                    totalCalories += videoTrackingInfo.caloriesBurned
                }
            }

           
            print("Total Calories Burned for \(exerciseType) today: \(totalCalories)")
            return totalCalories
        } else {
            print("No video tracking information found for today.")
            return 0.0
        }
    }

   
                
         
    func calculateDayOfWeek(for date: Date, section: Int, item: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"  // This will give you abbreviated day names (e.g., "Mon", "Tue")
        let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let index = (item + Calendar.current.firstWeekday - 1) % 7
        return daysOfWeek[index]
    }
   

    
        
        
        private func fetchData() {
            APICaller.shared.getWorkoutSummary { [weak self ] result in
                switch result {
                case.success(let model):
                    DispatchQueue.main.async {
                        self?.exerciseData = model.exercises
                        self?.calculateAndReloadCollectionView()
                       
                        
                      
                       
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
           
            
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
                updateCollectionViewData()
             
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
            updateCollectionViewData()
           
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
            updateCollectionViewData()
            print("Total Heart Rate for Today: \(totalHeartRate)")
            return totalHeartRate
        } else {
            print("No video tracking information found for today.")
            return 0
        }
    }
    
   

    

    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
       
        switch section {
        case 0:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 2, trailing: 10)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
          
            
            
            
            return section
       
            
        case 1:
           
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.16), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 2, trailing: 0)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(55)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
          
            
            return section
        case 2:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 2, trailing: 10)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
          
            
            
            
            return section
            
        case 3:
            
              let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
              item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 2)

              let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(130)), subitems: [item])
              let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(140)), subitems: [verticalGroup])

              let section = NSCollectionLayoutSection(group: horizontalGroup)
              section.orthogonalScrollingBehavior = .continuous
              return section
            
       
        case 4:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 10, trailing: 10)
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), repeatingSubitem: item, count: 1)
            
            
            
            let section = NSCollectionLayoutSection(group: group)
           
            
            
            
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
extension ProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 7
        case 2:
            return 1
        case 3:
            return 3
           
        case 4:
            return exerciseData.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysDateCollectionViewCell.identifier, for: indexPath) as? TodaysDateCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            // Configure the cell
            cell.configureTodayDateLabel()
            
            return cell
            
            
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.identifier, for: indexPath) as? WeekCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let daysOfWeek = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            let dayOfWeek = daysOfWeek[indexPath.item]
            
            let currentDate = Date()
            let calendar = Calendar.current
            
            
            if let dateForDay = calendar.date(bySetting: .weekday, value: indexPath.item + 1, of: currentDate),
               let dayOfMonth = calendar.dateComponents([.day], from: dateForDay).day {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd"
                let date = dateFormatter.string(from: dateForDay)
                
                let isToday = calendar.isDateInToday(dateForDay)
                
                
                
                
                cell.configure(dayOfWeek: dayOfWeek, date: date, isToday: isToday)
            }
            
            
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.identifier, for: indexPath) as? SummaryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let totalDurationForToday = self.getTotalDurationForToday()

                // Configure the cell with the total exercise duration
                cell.configure(totalDuration: totalDurationForToday)

            return cell
            
        case 3:
            if indexPath.item == 0 {
                // Create and configure Calories cell
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CaloriesCollectionViewCell.identifier, for: indexPath) as? CaloriesCollectionViewCell else {
                    
                    return UICollectionViewCell()
                }
                
                
                
                let totalCaloriesForToday = self.getTotalCaloriesForToday()
                cell.updateCalories(calories: totalCaloriesForToday)
                
               
                
                
                return cell
            } else if indexPath.item == 1 {
                // Create and configure Heartrate cell
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeartrateCollectionViewCell.identifier, for: indexPath) as? HeartrateCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let totalHeartrateForToday = self.getTotalHeartRateForToday()
                cell.updateHeartRate(heartRate: totalHeartrateForToday)
               
               
               

                
                return cell
            } else {
                // Create and configure Duration cell
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DurationCollectionViewCell.identifier, for: indexPath) as? DurationCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                let totalDurationForToday = self.getTotalDurationForToday()
                cell.updateDuration(durationInHours: totalDurationForToday)
               
               
                
                
                
               

               
                
                return cell
            }
      
            
           
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutSummaryCollectionViewCell.identifier, for: indexPath) as? WorkoutSummaryCollectionViewCell else {
                return UICollectionViewCell()
            }

            var viewModel = exerciseData[indexPath.row]
            let exerciseType = viewModel.name

            // Fetch the video tracking info for the current date and exercise type
            let currentDate = Date()
            let videoTrackingInfoArray = getVideoTrackingInfo(for: currentDate)

            if let videoTrackingInfo = videoTrackingInfoArray.first(where: { $0.type == exerciseType }) {
                // Use the start time and end time here
                viewModel.startDate = videoTrackingInfo.startTime
                viewModel.endDate = videoTrackingInfo.endTime

                // Format the startTime and endTime to display only the time part
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"

                if let startTime = videoTrackingInfo.startTime {
                    viewModel.startTimeString = dateFormatter.string(from: startTime)
                    print("Formatted Start Time: \(viewModel.startTimeString ?? "N/A")")
                }

                if let endTime = videoTrackingInfo.endTime {
                    viewModel.endTimeString = dateFormatter.string(from: endTime)
                    print("Formatted End Time: \(viewModel.endTimeString ?? "N/A")")
                }
                // Fetch additional information and configure the cell
                let progressForExerciseType = getProgressForExerciseType(exerciseType)
                let totalCaloriesForExerciseType = getTotalCaloriesForExerciseType(exerciseType)
                let totalHeartRateForExerciseType = getTotalHeartRateForExerciseType(exerciseType)
                let totalDurationForExerciseType = getTotalDurationForExerciseType(exerciseType)

                cell.configure(
                    viewModel: viewModel,
                    totalCalories: totalCaloriesForExerciseType,
                    progress: progressForExerciseType,
                    heartRate: totalHeartRateForExerciseType,
                    durationInMinutes: totalDurationForExerciseType,
                    startTime: viewModel.startDate, endTime: viewModel.endDate)
               
               
               
            } else {
                print("No video tracking information found for today and \(exerciseType).")
            }

            return cell

        default:
            return UICollectionViewCell()
        }
    }
    
}

    

