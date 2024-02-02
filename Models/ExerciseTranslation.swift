//
//  ExerciseTranslation.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 13/12/2023.
//


struct ExerciseTranslation: Codable {
    let id: Int
    let uuid: String
    let name: String
    //let exerciseBase: Int
    let description: String
   
   
    
    //let created: String
    //let language: Int
    //let licenseAuthor: String?
    
    enum CodingKeys: String, CodingKey {
      case id, name, uuid,  description
      
        //uuid, name, description, created, language
//        case exerciseBase = "exercise_base"
//        case licenseAuthor = "license_author"
    }
}

struct ExerciseTranslationList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [ExerciseTranslation]
}
