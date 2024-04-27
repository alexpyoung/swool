//
//  Weight.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

enum MassUnit: Codable, CustomStringConvertible {
    case pound
    case kilogram

    var description: String {
        switch self {
        case .pound: return "lbs"
        case .kilogram: return "kgs"
        }
    }
}

struct Mass: Codable {
    let value: Float
    let unit: MassUnit
}

enum Weight: Codable {
    case bilateral(mass: Mass)
    case unilateral(left: Mass, right: Mass)
}
