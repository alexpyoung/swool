//
//  EditWorkoutView.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import RealmSwift
import SwiftUI

struct EditWorkoutView: View {
    
    @ObservedRealmObject var workout: Workout
    @State private var exerciseToDelete: Exercise?
    @State private var alertIsVisible = false
    @State private var datePickerIsVisible = false
    @State private var exercisePickerIsVisible = false
    
    var body: some View {
        VStack {
            HStack {
                Text(workout.date.format("MM/dd/yy 'at' h:mm a"))
                    .font(.title)
                    .fontWeight(.bold)
                    .onTapGesture {
                        datePickerIsVisible = true
                    }
                Spacer()
            }
            ScrollView {
                ForEach(workout.exercises) { exercise in
                    EditExerciseView(exercise: exercise) {
                        exerciseToDelete = $0
                    }
                    .padding(.vertical, .small)
                    Spacer().frame(height: .medium)
                }
            }
            Button("Add Exercise") { alertIsVisible = true }
                .buttonStyle(FilledButton())
            AlertItemView(item: $exerciseToDelete) { exercise in
                Alert(
                    title: Text("Are you sure you want to delete \(exercise.name)?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Delete")) {
                        if let index = workout.exercises.index(of: exercise) {
                            $workout.exercises.remove(at: index)
                        }
                    }
                )
            }
            AlertBoolView(isPresented: $alertIsVisible) {
                Alert(
                    title: Text("Would you like to copy an existing exercise or create new one?"),
                    primaryButton: .default(Text("New")) {
                        $workout.exercises.append(Exercise())
                    },
                    secondaryButton: .default(Text("Copy")) {
                        exercisePickerIsVisible = true
                    }
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.medium)
        .onTapGesture {
            UIApplication.shared.resignFirstResponder()
        }
        .sheet(isPresented: $datePickerIsVisible) {
            DatePicker("", selection: $workout.date)
                .labelsHidden()
                .datePickerStyle(.graphical)
                .presentationDetents([.height(420)])
        }
        .sheet(isPresented: $exercisePickerIsVisible) {
            ExercisePickerView {
                $workout.exercises.append(Exercise(existing: $0))
            }
        }
    }
}
