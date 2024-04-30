//
//  FloatTextField.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

struct FloatTextField: View {

    @Binding var number: Float
    @State private var input = ""

    init(number: Binding<Float>) {
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
                guard let number = Float(newValue) else { return }
                self.number = number
            }
    }
}
