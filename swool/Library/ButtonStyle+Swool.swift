//
//  ButtonStyle+Swool.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

struct FilledButton: ButtonStyle {

    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .padding(.horizontal, .large)
            .padding(.vertical, .medium)
            .foregroundColor(.white)
            .background(.blue)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .cornerRadius(.small)
    }
}

private struct ButtonsView: View {

    var body: some View {
        VStack {
            Button("Lorem ipsum dolor sit amet") {}
                .buttonStyle(FilledButton())
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
