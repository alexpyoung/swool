//
//  Exercise.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import RealmSwift

final class Exercise: Object {

    @Persisted var name: String = ""
    @Persisted var sets = List<Set>()
    @Persisted var interSetRest: Int = 0
}
