//
//  ExerciseImage.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 13/12/2023.
//

import Foundation
struct ExerciseImage: Codable {
    let id: Int
    let uuid: String
    let exerciseBase: Int
    let exerciseBaseUuid: String
    let image: String
    //let isMain: Bool
    let style: String
    let license: Int
    let licenseTitle: String?
    let licenseObjectUrl: String?
    let licenseAuthor: String?
    let licenseAuthorUrl: String?
    let licenseDerivativeSourceUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uuid, image, style, license
        case exerciseBase = "exercise_base"
        case exerciseBaseUuid = "exercise_base_uuid"
        case licenseTitle = "license_title"
        case licenseObjectUrl = "license_object_url"
        case licenseAuthor = "license_author"
        case licenseAuthorUrl = "license_author_url"
        case licenseDerivativeSourceUrl = "license_derivative_source_url"
    }
}
struct ExerciseImageList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [ExerciseImage]
}
