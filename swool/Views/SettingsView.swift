//
//  SettingsView.swift
//  swool
//
//  Created by Alex Young on 4/30/24.
//

import SwiftUI

enum SchemeOption: String, CaseIterable, Identifiable {
    case light
    case dark

    var id: String { self.rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .dark: return .dark
        case .light: return .light
        }
    }
}

struct SettingsView: View {

    @AppStorage("colorScheme") private var scheme: SchemeOption = .dark

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Color Scheme")
                    .fontWeight(.bold)
                    .padding(.vertical, .xsmall)
                Picker("", selection: $scheme) {
                    ForEach(SchemeOption.allCases, id: \.self) {
                        Text($0.rawValue.capitalized).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
            .padding(.medium)
            .navigationTitle("Secret Menu")
        }
        .preferredColorScheme(scheme.colorScheme)
    }
}
