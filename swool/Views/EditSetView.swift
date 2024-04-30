//
//  EditSetView.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import RealmSwift
import SwiftUI

extension Int: Identifiable {

    public var id: String {
        self.description
    }
}
//extension Binding: Identifiable where Value: Hashable {
//
//    var id: Hashable {
//        self.wrappedValue
//    }
//}

struct EditSetView: View {

    let index: Int
    @ObservedRealmObject var set: Set
    @State private var edit: Binding<Int>?
    
    var body: some View {
        HStack {
            Text("\(index + 1).")
            IntTextField(number: $set.repetitions)
            Text("reps x")
            if let weight = set.weight {
                switch weight {
                case let .bilateral(left, right):
                    Text("L:")
                    FloatTextField(number: Binding(get: { left.value }, set: { newValue in
                        if let set = set.thaw(),
                           let realm = set.realm {
                            try? realm.write {
                                set.weight = .bilateral(left: Mass(value: newValue, unit: left.unit), right: right)
                            }
                        }
                    }))
                    Text(left.unit.description)
                    Text("R:")
                    FloatTextField(number: Binding(get: { right.value }, set: { newValue in
                        if let set = set.thaw(),
                           let realm = set.realm {
                            try? realm.write {
                                set.weight = .bilateral(left: left, right: Mass(value: newValue, unit: right.unit))
                            }
                        }
                    }))
                    Text(right.unit.description)
                case let .unilateral(mass):
                    FloatTextField(number: Binding(get: { mass.value }, set: { newValue in
                        if let set = set.thaw(),
                           let realm = set.realm {
                            try? realm.write {
                                set.weight = .unilateral(mass: Mass(value: newValue, unit: mass.unit))
                            }
                        }
                    }))
                    Text(mass.unit.description)
                }
            } else if let duration = set.duration {
                DoubleTextField(number: Binding(get: { duration }, set: { newValue in
                    if let set = set.thaw(),
                       let realm = set.realm {
                        try? realm.write {
                            set.duration = newValue
                        }
                    }
                }))
                Text("s")
            }
            Spacer()
        }
        .padding(.xsmall)
        .sheet(item: $edit) {
            NumberPickerView(existing: $0)
        }
    }
}
