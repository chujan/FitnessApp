//
//  NutritionData.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 27/01/2024.
//

import Foundation
struct NutritionData: Codable {
    var nutrition: [Nutrition]
    
    
}
struct Nutrition: Codable {
    var category: String
    var description: String
    var foods: [Food]
}
struct Food: Codable {
    var name: String
    var description: String
    var ingredients: [String]
    var instructions: String
    var kcal: Int
    var time: Int
    var imageName: String?
    var placeholderImageName: String?
}
