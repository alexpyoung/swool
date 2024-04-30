//
//  Exercise.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import RealmSwift

final class Exercise: Object, ObjectKeyIdentifiable {

    @Persisted(primaryKey: true) var _id = ObjectId.generate()
    @Persisted var name = ""
    @Persisted var sets = List<Set>()
    @Persisted var interSetRest: Int = 0
    @Persisted var notes = ""

    convenience init(existing: Exercise) {
        self.init()
        self.name = existing.name
        existing.sets
            .map(Set.init)
            .forEach(self.sets.append)
        self.interSetRest = existing.interSetRest
        self.notes = existing.notes
    }
}
