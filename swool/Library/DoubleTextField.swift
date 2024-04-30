//
//  DoubleTextField.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

struct DoubleTextField: View {

    @Binding var number: Double
    @State private var input = ""

    init(number: Binding<Double>) {
        self._number = number
        self._input = State(initialValue: number.wrappedValue.rounded)
    }

    var body: some View {
        TextField("", text: $input)
            .multilineTextAlignment(.center)
            .padding(.vertical, .xsmall)
            .padding(.horizontal, .small)
            .fixedSize()
            .roundedBorder()
            .keyboardType(.numberPad)
            .onChange(of: input) { newValue in
                guard let number = Double(newValue) else { return }
                self.number = number
            }
    }
}
