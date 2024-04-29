//
//  NumberPickerView.swift
//  swool
//
//  Created by Alex Young on 4/27/24.
//

import SwiftUI

struct NumberPickerView: View {

    @Environment(\.dismiss) var dismiss
    @Binding var existing: Int
    @State private var changed: Int

    init(existing: Binding<Int>) {
        self._existing = existing
        self._changed = State(initialValue: existing.wrappedValue)
    }

    var body: some View {
        NavigationView {
                Picker("", selection: $changed) {
                    ForEach(1...100, id: \.self) {
                        Text($0.description)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            .navigationBarItems(
                leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Done") {
                existing = changed
                dismiss()
            })
        }
        .presentationDetents([.height(200)])
    }
}

struct NumberPickerView_Previews: PreviewProvider {

    private struct ContainerView: View {
        @State private var number = 0
        var body: some View {
            NumberPickerView(existing: $number)
        }
    }

    static var previews: some View {
        ContainerView()
    }
}
