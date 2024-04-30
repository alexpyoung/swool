//
//  IntTextField.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

struct IntTextField: View {

    @Binding var number: Int
    @State private var input = ""

    init(number: Binding<Int>) {
        self._number = number
        self._input = State(initialValue: number.wrappedValue.description)
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
                guard let number = Int(newValue) else { return }
                self.number = number
            }
    }
}
