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
    @State private var pickerIsVisible = false

    var body: some View {
        VStack {
            HStack {
                Text(workout.date.format("MM/dd/yy 'at' h:mm a"))
                    .font(.title)
                    .fontWeight(.bold)
                    .onTapGesture {
                        pickerIsVisible = true
                    }
                Spacer()
            }
            if let exercise = workout.exercise {
                EditExerciseView(exercise: exercise)
            } else {
                EmptyView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, .medium)
        .sheet(isPresented: $pickerIsVisible) {
            DatePicker("", selection: $workout.date)
                .labelsHidden()
                .datePickerStyle(.graphical)
                .presentationDetents([.height(400)])
        }
    }
}
