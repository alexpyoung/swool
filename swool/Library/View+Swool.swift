//
//  View+Swool.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import SwiftUI

extension View {

    func roundedBorder(radius: CGFloat = 4, color: Color = .gray, stroke: CGFloat = 0.5) -> some View {
        self.cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius).stroke(color, lineWidth: stroke)
            )
    }
}
