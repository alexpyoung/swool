//
//  IntTextField.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

struct IntTextField<T: Hashable>: View {

    @Binding var number: Int
    var focused: FocusState<T>.Binding
    let field: T
    @State private var input = ""

    init(number: Binding<Int>, focused: FocusState<T>.Binding, field: T) {
        self._number = number
        self.focused = focused
        self.field = field
        self._input = State(initialValue: number.wrappedValue.description)
    }

    var body: some View {
        TextField("", text: $input)
            .focused(focused, equals: field)
            .multilineTextAlignment(.center)
            .truncationMode(.tail)
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
