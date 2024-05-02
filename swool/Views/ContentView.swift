//
//  ContentView.swift
//  swool
//
//  Created by Alex Young on 4/30/24.
//

import RealmSwift
import SwiftUI

struct ContentView: View {

    @AppStorage("colorScheme") private var scheme: SchemeOption = .dark

    var body: some View {

        TabView {
            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "trophy")
                }
            ExercisesView()
                .tabItem {
                    Label("Exercises", systemImage: "dumbbell")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .environment(
            \.realmConfiguration,
             Realm.Configuration(schemaVersion: 3)
        )
        .preferredColorScheme(scheme.colorScheme)
    }
}
