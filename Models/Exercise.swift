//
//  Workout.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 12/12/2023.
//

import Foundation

struct Exercise: Codable {
    let id: Int
    let name: String
}

// ExerciseList struct representing the overall API response
struct ExerciseList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Exercise]
}

//struct ExerciseData: Codable {
//    let exercises: [Exercise]
//    let workouts: [Workout]
//}
//
//struct Exercise: Codable {
//    let name: String
//    let description: String
//    let image: String
//}
//
//struct Workout: Codable {
//    let name: String
//    let exercises: [ExerciseDetail]
//}
//
//struct ExerciseDetail: Codable {
//    let name: String
//    let sets: Int?
//    let reps: Int?
//    let durationSeconds: Int?
//}
