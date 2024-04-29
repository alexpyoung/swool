//
//  HomeView.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import RealmSwift
import SwiftUI

private struct ListItemView: View {

    @ObservedRealmObject var workout: Workout

    var body: some View {
        Text("\(workout.date) - \(workout.exercise?.name ?? "")")
    }
}

struct WorkoutsView: View {

    @Environment(\.realm) private var realm
    @ObservedResults(Workout.self) private var workouts
    @State private var modalIsVisible = false

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts, content: ListItemView.init)
                    .onDelete(perform: $workouts.remove)
            }
            .navigationTitle("Workouts")
            .navigationBarItems(trailing: add)
        }
        .sheet(isPresented: $modalIsVisible) {
            EditWorkoutView()
        }
    }

    private var add: some View {
        Button(action: { modalIsVisible = true }) {
            Image(systemName: "plus")
        }
    }
}
