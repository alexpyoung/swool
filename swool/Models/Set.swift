//
//  Set.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import Foundation
import RealmSwift

final class Set: Object, ObjectKeyIdentifiable {

    @Persisted(primaryKey: true) private var _id = ObjectId.generate()
    @Persisted var repetitions: Int = 0
    @Persisted private var _weight: Data?
    @Persisted var duration: TimeInterval?
    var weight: Weight? {
        get {
            guard let value = _weight else { return nil }
            return try? JSONDecoder().decode(Weight.self, from: value)
        }
        set { _weight = try? JSONEncoder().encode(newValue) }
    }

    convenience init(weight: Weight, repetitions: Int = 0) {
        self.init()
        self.repetitions = repetitions
        self._weight = try? JSONEncoder().encode(weight)
    }

    convenience init(duration: TimeInterval, repetitions: Int = 0) {
        self.init()
        self.repetitions = repetitions
        self.duration = duration
    }

    convenience init(existing: Set) {
        self.init()
        self.repetitions = existing.repetitions
        self._weight = existing._weight
        self.duration = existing.duration
    }
}
