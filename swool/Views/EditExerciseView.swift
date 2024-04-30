//
//  EditWorkoutView.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import RealmSwift
import SwiftUI

enum ExerciseType: String, CaseIterable, Identifiable {
    case unilateral
    case bilateral
    case timed

    var id: String { self.rawValue }
}

struct EditExerciseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.realm) private var realm
    @ObservedRealmObject var exercise: Exercise
    @State private var offset = CGFloat.zero
    @State private var type: ExerciseType = .unilateral
    @State private var unit: MassUnit = .pound

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Exercise Name", text: $exercise.name)
                    .font(.title2)
                    .underline()
                Button(action: {
                    let set: Set
                    if let last = exercise.sets.last, let weight = last.weight {
                        set = Set(weight: weight, repetitions: last.repetitions)
                    } else if let last = exercise.sets.last, let duration = last.duration {
                        set = Set(duration: duration, repetitions: last.repetitions)
                    } else {
                        switch type {
                        case .unilateral:
                            set = Set(weight: .unilateral(mass: Mass(value: 0, unit: unit)))
                        case .bilateral:
                            set = Set(weight: .bilateral(
                                left: Mass(value: 0, unit: unit),
                                right: Mass(value: 0, unit: unit)
                            ))
                        case .timed:
                            set = Set(duration: 0)
                        }
                    }
                    $exercise.sets.append(set)
                }) {
                    Image(systemName: "plus.app.fill")
                }
                .padding(.vertical, .xsmall)
                .padding(.horizontal, .small)
            }
            .padding(.bottom, .xsmall)
            if exercise.sets.isEmpty {
                HStack {
                    Picker("Type", selection: $type) {
                        ForEach(ExerciseType.allCases, id: \.self) {
                            Text($0.rawValue.capitalized).tag($0)
                        }
                    }
                    if [.unilateral, .bilateral].contains(type) {
                        Picker("Unit", selection: $unit) {
                            ForEach(MassUnit.allCases, id: \.self) {
                                Text($0.description).tag($0)
                            }
                        }
                    }
                }
            }
            ForEach(exercise.sets.enumerated().map { $0 }, id: \.offset) { index, `set` in
                VStack {
                    HStack {
                        EditSetView(index: index, set: `set`)
                        Button(action: {
                            $exercise.sets.remove(at: index)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .padding(.vertical, .xsmall)
                                .padding(.horizontal, .small)
                        }
                    }
                    Divider()
                }
            }
            Spacer().frame(height: .small)
            VStack(alignment: .leading) {
                Text("NOTES")
                    .fontWeight(.bold)
                TextEditor(text: $exercise.notes)
                    .padding(.xsmall)
                    .roundedBorder()
            }
            .font(.caption)
        }
    }
}
