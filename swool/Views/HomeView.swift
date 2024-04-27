//
//  HomeView.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import RealmSwift
import SwiftUI

struct HomeView: View {

    @ObservedResults(Workout.self) var workouts

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    Text("\(workout.date) - \(workout.exercise?.name ?? "")")
                }
                .onDelete(perform: $workouts.remove)
            }
            .navigationTitle("Workouts")
            .navigationBarItems(trailing: add)
        }
    }

    var add: some View {
        Button(action: { $workouts.append(Workout(exercise: Exercise()))}) {
            Image(systemName: "plus")
        }
    }
}
