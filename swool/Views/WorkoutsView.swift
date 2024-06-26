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
        NavigationLink(destination: EditWorkoutView(workout: workout)) {
            Text(workout.date.humanReadable())
        }
    }
}

struct WorkoutsView: View {
    
    @Environment(\.realm) private var realm
    @ObservedResults(
        Workout.self,
        sortDescriptor: SortDescriptor(keyPath: \Workout.date, ascending: false)
    ) private var workouts
    @State private var workout: Workout?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts, content: ListItemView.init)
                    .onDelete(perform: $workouts.remove)
            }
            .navigationTitle("Workouts")
            .navigationBarItems(trailing: add)
        }
        .sheet(item: $workout) {
            EditWorkoutView(workout: $0)
                .padding(.top, .medium)
        }
    }
    
    private var add: some View {
        Button(action: {
            try? realm.write {
                let workout = Workout()
                $workouts.append(workout)
                self.workout = workout
            }
        }) {
            Image(systemName: "plus")
        }
    }
}
