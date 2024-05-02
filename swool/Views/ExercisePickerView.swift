//
//  ExercisePickerView.swift
//  swool
//
//  Created by Alex Young on 4/30/24.
//

import RealmSwift
import SwiftUI

struct ExercisePickerView: View {
    
    let didSelect: (Exercise) -> Void
    @Environment(\.dismiss) private var dismiss
    @ObservedResults(
        Exercise.self,
        sortDescriptor: SortDescriptor(keyPath: \Exercise._id.timestamp)
    ) private var query
    private var exercises: [Exercise] {
        return query.reduce(into: [String:Exercise]()) { (result, exercise) in
            result[exercise.name] = query.last { $0.name == exercise.name }
        }
        .map { $0.value }
        .sorted { $0._id.timestamp > $1._id.timestamp }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(exercises) { exercise in
                    HStack {
                        Text(exercise.name)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.system(size: .medium))
                    }
                    .onTapGesture {
                        didSelect(exercise)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Exercises")
        }
    }
}
