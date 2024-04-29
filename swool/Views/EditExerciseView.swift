//
//  EditWorkoutView.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import RealmSwift
import SwiftUI

enum Laterality: String, CaseIterable {
    case unilateral
    case bilateral
}

struct EditExerciseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.realm) private var realm
    @ObservedRealmObject var exercise: Exercise
    @State private var laterality: Laterality = .unilateral
    
    var body: some View {
        VStack {
            HStack {
                TextField("Exercise Name", text: $exercise.name)
                    .font(.title2)
                Button(action: {
                    $exercise.sets.append(Set())
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding(.bottom, .small)
            Picker("Laterality", selection: $laterality) {
                ForEach(Laterality.allCases, id: \.rawValue) {
                    Text($0.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            List(exercise.sets.enumerated().map { $0 }, id: \.offset, rowContent: EditSetView.init)
                .listStyle(.plain)
        }
    }
}
