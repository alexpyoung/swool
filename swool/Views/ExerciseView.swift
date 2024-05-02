//
//  ExerciseView.swift
//  swool
//
//  Created by Alex Young on 5/1/24.
//

import RealmSwift
import SwiftUI

private extension Weight {

    var title: String {
        switch self {
        case let .unilateral(mass):
            return mass.description
        case let .bilateral(left, right):
            return "L: \(left.description) R: \(right.description)"
        }
    }
}

private extension Set {

    var title: String {
        switch (weight, duration) {
        case let (.some(weight), nil):
            return weight.title
        case let (nil, .some(duration)):
            return "\(duration.rounded)s"
        case (.some, .some), (nil, nil):
            return "Invalid set type"
        }
    }
}

private struct RowView: View {

    @ObservedRealmObject var exercise: Exercise

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(exercise.sets.enumerated().map { $0 }, id: \.offset) { i, s in
                Text("\(i + 1). \(s.repetitions) x \(s.title)")
            }
            .monospaced()
            if !exercise.notes.isEmpty {
                VStack(alignment: .leading) {
                    Text("NOTES")
                        .fontWeight(.bold)
                        .padding(.vertical, .xsmall)
                    Text(exercise.notes)
                }
                .font(.caption)
            }
        }
    }
}

struct ExerciseView: View {

    let name: String
    @ObservedResults(
        Workout.self,
        sortDescriptor: SortDescriptor(keyPath: \Workout.date, ascending: false)
    ) private var workouts
    private var exercises: [(Date, Exercise)] {
        self.workouts
            .filter { $0.exercises.map { $0.name }.contains(self.name) }
            .map { workout in
                workout.exercises
                    .filter { $0.name == self.name }
                    .map { (workout.date, $0) }
            }
            .flatMap { $0 }
    }

    var body: some View {
        VStack {
            List {
                ForEach(exercises, id: \.1._id) { (date, exercise) in
                    Section(date.humanReadable()) {
                        RowView(exercise: exercise)
                    }
                }
            }
        }
    }
}
