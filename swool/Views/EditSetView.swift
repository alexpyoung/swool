//
//  EditSetView.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import RealmSwift
import SwiftUI

struct EditSetView: View {

    let index: Int
    @ObservedRealmObject var set: Set
    @State private var modalIsVisible = false

    var body: some View {
        HStack {
            Text("\(index + 1).")
            Text(set.repetitions.description)
                .frame(minWidth: 32)
                .roundedBorder()
                .onTapGesture {
                    modalIsVisible = true
                }
            Text("reps")
        }
        .sheet(isPresented: $modalIsVisible) {
            NumberPickerView(existing: $set.repetitions)
        }
    }
}
