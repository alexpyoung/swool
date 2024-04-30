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
}
