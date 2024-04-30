//
//  swoolApp.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import RealmSwift
import SwiftUI

@main
struct swoolApp: SwiftUI.App {
    
    var body: some Scene {
        WindowGroup {
            WorkoutsView()
                .environment(
                    \.realmConfiguration,
                     Realm.Configuration(schemaVersion: 2)
                )
        }
    }
}
