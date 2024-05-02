//
//  FloatTextField.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

struct FloatTextField<T: Hashable>: View {

    @Binding var number: Float
    var focused: FocusState<T>.Binding
    let field: T
    @State private var input = ""

    init(number: Binding<Float>, focused: FocusState<T>.Binding, field: T) {
        self._number = number
        self.focused = focused
        self.field = field
        self._input = State(initialValue: number.wrappedValue.rounded)
    }

    var body: some View {
        TextField("", text: $input)
            .focused(focused, equals: field)
            .onChange(of: input) { newValue in
                guard let number = Float(newValue) else { return }
                self.number = number
            }
            .textFieldStyle(NumberFieldStyle())
    }
}
