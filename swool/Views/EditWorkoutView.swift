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

struct EditWorkoutView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.realm) private var realm
    @ObservedRealmObject private var exercise = Exercise()
    @State private var date = Date()
    @State private var laterality: Laterality = .unilateral

    var body: some View {
        NavigationView {
            VStack {
                TextField("Exercise Name", text: $exercise.name)
                    .font(.title)
                    .fontWeight(.bold)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                Picker("Laterality", selection: $laterality) {
                    ForEach(Laterality.allCases, id: \.rawValue) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                List(exercise.sets.enumerated().map { $0 }, id: \.offset, rowContent: EditSetView.init)
                    .listStyle(.plain)
                Button("Add New Set") {
                    $exercise.sets.append(Set())
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationBarItems(trailing: close)
        }
        .onAppear { try? onAppear() }
    }

    private var close: some View {
        Button("Done") {
            if let exercise = self.exercise.thaw(),
               let realm = exercise.realm {
                try? realm.write {
                    realm.add(Workout(date: date, exercise: exercise))
                }
            }
            dismiss()
        }
    }

    private func onAppear() throws {
        try realm.write {
            realm.add(exercise)
        }
    }
}
