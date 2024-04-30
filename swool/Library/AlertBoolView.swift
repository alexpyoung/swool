//
//  AlertBoolView.swift
//  swool
//
//  Created by Alex Young on 4/30/24.
//

import SwiftUI

struct AlertBoolView: View {
    @Binding var isPresented: Bool
    var content: () -> Alert
    var body: some View {
        Spacer().frame(height: 0).alert(isPresented: $isPresented, content: content)
    }
}
