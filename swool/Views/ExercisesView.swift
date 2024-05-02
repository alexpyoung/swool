//
//  ExercisesView.swift
//  swool
//
//  Created by Alex Young on 5/1/24.
//

import RealmSwift
import SwiftUI

struct ExercisesView: View {

    @ObservedResults(
        Exercise.self,
        sortDescriptor: SortDescriptor(keyPath: \Exercise.name)
    ) private var exercises
    private var names: Swift.Set<String> {
        return Swift.Set(exercises.map { $0.name })
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(names.sorted(by: <), id: \.self) { name in
                    NavigationLink(destination: ExerciseView(name: name).navigationTitle(name)) {
                        Text(name)
                    }
                }
            }
            .navigationTitle("Exercises")
        }
    }
}
