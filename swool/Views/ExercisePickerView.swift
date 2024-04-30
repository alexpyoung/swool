//
//  ExercisePickerView.swift
//  swool
//
//  Created by Alex Young on 4/30/24.
//

import RealmSwift
import SwiftUI

extension Binding: Equatable where Value == Int {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

struct ExercisePickerView: View {
    
    let didSelect: (Exercise) -> Void
    @Environment(\.dismiss) private var dismiss
    @ObservedResults(Exercise.self) private var query
    private var exercises: [Exercise] {
        let sorted = query.sorted(by: \._id.timestamp)
        return query.reduce(into: [String:Exercise]()) { (result, exercise) in
            result[exercise.name] = sorted.last { $0.name == exercise.name }
        }
        .map { $0.value }
        .sorted { $0._id.timestamp > $1._id.timestamp }
    }
    @State private var fuckyou = 0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(exercises) { exercise in
                    HStack {
                        Text(exercise.name)
                        Spacer()
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
