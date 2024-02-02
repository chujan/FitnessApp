//
//  ExceriseData.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 14/12/2023.
//

import Foundation


struct ExerciseData: Codable {
    var exercises: [Exercises]
    let workouts: [Workout]
}

struct Exercises: Codable {
    let name: String
    let description: String
    var imageName: String?
    var startDate: Date?
    var endDate: Date?
    var set: Int?
    var rep: Int?
    let videoURL: String?
    var videoFileName: String?
    var placeholderImageName: String?
    var caloriesBurned: Double?
    var averageHeartRate: Double?
    var durationMinutes: Int?
    var type: String?
    var progress: Int?
    var startTimeString: String?
    var endTimeString: String?
    
    enum CodingKeys: String, CodingKey {
           case name, description,imageName,placeholderImageName,startDate,endDate, set, rep,videoURL,videoFileName,caloriesBurned,averageHeartRate,durationMinutes,type,startTimeString,endTimeString
       }
   
}

struct Workout: Codable {
    let name: String
    let exercises: [ExerciseDetail]
}

struct ExerciseDetail: Codable {
    let name: String
    let sets: Int?
    let reps: Int?
    let durationSeconds: Int?
}

extension Exercises {
    init(name: String, description: String, imageName: String, videoURL: String, videoFileName: String) {
        self.name = name
        self.description = description
        self.imageName = imageName
        self.videoURL = videoURL
        self.videoFileName = videoFileName

        // User information (replace these with actual values)
        let age = 30
        let restingHeartRate = 70 // bpm

        // Exercise information (replace these with actual values)
        let exerciseDurationMinutes = 30 // in minutes
        let exerciseIntensity = 6.0 // This can be a subjective measure of exercise intensity on a scale of 1 to 10

        // Constants for calculation
        let caloriesPerMinute = 5.0 // This is a general estimate; you can adjust based on the type of exercise
        let heartRateReserveFactor = 0.7 // This is a general estimate; you can adjust based on the individual's fitness level

        // Calculate calories burned
        self.caloriesBurned = caloriesPerMinute * Double(exerciseDurationMinutes) * (heartRateReserveFactor * Double(restingHeartRate) + (1.0 - heartRateReserveFactor) * exerciseIntensity)

        // Calculate average heart rate
        self.averageHeartRate = heartRateReserveFactor * Double(restingHeartRate) + (1.0 - heartRateReserveFactor) * exerciseIntensity

        // Set exercise duration
        self.durationMinutes = exerciseDurationMinutes
    }
}

