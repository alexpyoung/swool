//
//  Weight.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import Foundation

enum MassUnit: Codable, CaseIterable, Identifiable, CustomStringConvertible {
    case pound
    case kilogram

    var id: String {
        self.description
    }

    var description: String {
        switch self {
        case .pound: return "lbs"
        case .kilogram: return "kgs"
        }
    }
}

struct Mass: Codable, CustomStringConvertible {
    let value: Float
    let unit: MassUnit

    var description: String {
        return "\(value.rounded) \(unit.description)"
    }
}

enum Weight: Codable {
    case unilateral(mass: Mass)
    case bilateral(left: Mass, right: Mass)
}
