//
//  Set.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import Foundation
import RealmSwift

final class Set: Object {
    @Persisted var repetitions: Int = 1
    @Persisted var _weight: Data?
    var weight: Weight? {
        get {
            guard let value = _weight else { return nil }
            return try? JSONDecoder().decode(Weight.self, from: value)
        }
        set { _weight = try? JSONEncoder().encode(newValue) }
    }

    convenience init(weight: Weight) {
        self.init()
        self._weight = try! JSONEncoder().encode(weight)
    }
}
