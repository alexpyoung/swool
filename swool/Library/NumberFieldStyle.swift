//
//  NumberFieldStyle.swift
//  swool
//
//  Created by Alex Young on 5/1/24.
//

import SwiftUI

struct NumberFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .multilineTextAlignment(.center)
            .truncationMode(.tail)
            .keyboardType(.numberPad)
            .padding(.vertical, .xsmall)
            .padding(.horizontal, .small)
            .fixedSize()
            .roundedBorder()
            .contentShape(Rectangle())
            .background(Color.clear)
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.becomeFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}
