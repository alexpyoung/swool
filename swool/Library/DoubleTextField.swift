//
//  DoubleTextField.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

struct DoubleTextField<T: Hashable>: View {

    @Binding var number: Double
    var focused: FocusState<T>.Binding
    let field: T
    @State private var input = ""
    
    init(number: Binding<Double>, focused: FocusState<T>.Binding, field: T) {
        self._number = number
        self.focused = focused
        self.field = field
        self._input = State(initialValue: number.wrappedValue.rounded)
    }

    var body: some View {
        TextField(number.rounded, text: $input)
            .focused(focused, equals: field)
            .onChange(of: input) { newValue in
                guard let number = Double(newValue) else { return }
                self.number = number
            }
            .textFieldStyle(NumberFieldStyle())
    }
}
