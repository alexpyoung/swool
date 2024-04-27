//
//  Workout.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import Foundation
import RealmSwift

final class Workout: Object, ObjectKeyIdentifiable {

    @Persisted(primaryKey: true) var _id = ObjectId.generate()
    @Persisted var date = Date()
    @Persisted var exercise: Exercise?

    convenience init(exercise: Exercise) {
        self.init()
        self.date = date
        self.exercise = exercise
    }
}
