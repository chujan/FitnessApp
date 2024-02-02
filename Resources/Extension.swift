//
//  Extension.swift
//  FitnessApp
//
//  Created by Jennifer Chukwuemeka on 13/12/2023.
//

import Foundation
extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
