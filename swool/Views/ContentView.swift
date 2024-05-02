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
        WorkoutsView()
            .environment(
                \.realmConfiguration,
                 Realm.Configuration(schemaVersion: 3)
            )
            .preferredColorScheme(scheme.colorScheme)
    }
}
