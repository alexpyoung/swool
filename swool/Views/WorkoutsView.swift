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
    @ObservedResults(Workout.self) private var workouts
    @State private var sheetIsVisible = false
    @State private var workout: Workout?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts, content: ListItemView.init)
                    .onDelete(perform: $workouts.remove)
            }
            .navigationTitle("Workouts")
            .navigationBarItems(trailing: settings)
            .navigationBarItems(trailing: add)
        }
        .sheet(item: $workout) {
            EditWorkoutView(workout: $0)
                .padding(.top, .large)
        }
        .sheet(isPresented: $sheetIsVisible) {
            SettingsView()
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

    private var settings: some View {
        Button(action: {
            sheetIsVisible = true
        }) {
            Image(systemName: "gearshape")
        }
        .preferredColorScheme(.dark)
    }
}
