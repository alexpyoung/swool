//
//  AlertItemView.swift
//  swool
//
//  Created by Alex Young on 4/30/24.
//

import SwiftUI

struct AlertItemView<Item: Identifiable>: View {
    @Binding var item: Item?
    var content: (Item) -> Alert
    var body: some View {
        Spacer().frame(height: 0).alert(item: $item, content: content)
    }
}
