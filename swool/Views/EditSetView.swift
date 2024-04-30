//
//  EditSetView.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import RealmSwift
import SwiftUI

private enum Field {
    case repetitions
    case weight
    case left
    case right
    case duration
    
    func previous() -> Self? {
        switch self {
        case .repetitions:
            return nil
        case .weight, .left, .duration:
            return .repetitions
        case .right:
            return .left
        }
    }
    
    func next(set: Set) -> Self? {
        switch self {
        case .repetitions:
            if let weight = set.weight {
                switch weight {
                case .bilateral: return .left
                case .unilateral: return .weight
                }
            } else if set.duration != nil {
                return .duration
            } else {
                return nil
            }
        case .left:
            return .right
        case .weight, .right, .duration:
            return nil
        }
    }
}

struct EditSetView: View {
    
    let index: Int
    @ObservedRealmObject var set: Set
    @FocusState private var focused: Field?
    
    var body: some View {
        HStack {
            Text("\(index + 1).")
            IntTextField(number: $set.repetitions, focused: $focused, field: Field.repetitions)
            Text("x")
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
                    }), focused: $focused, field: Field.left)
                    Text("R:")
                    FloatTextField(number: Binding(get: { right.value }, set: { newValue in
                        if let set = set.thaw(),
                           let realm = set.realm {
                            try? realm.write {
                                set.weight = .bilateral(left: left, right: Mass(value: newValue, unit: right.unit))
                            }
                        }
                    }), focused: $focused, field: Field.right)
                    Text(right.unit.description)
                case let .unilateral(mass):
                    FloatTextField(number: Binding(get: { mass.value }, set: { newValue in
                        if let set = set.thaw(),
                           let realm = set.realm {
                            try? realm.write {
                                set.weight = .unilateral(mass: Mass(value: newValue, unit: mass.unit))
                            }
                        }
                    }), focused: $focused, field: Field.weight)
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
                }), focused: $focused, field: Field.duration)
                Text("s")
            }
            Spacer()
        }
        .padding(.xsmall)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if focused != nil {
                    HStack {
                        Button(action: {
                            focused = focused?.previous()
                        }) {
                            Image(systemName: "chevron.up")
                        }
                        .disabled(focused == Field.repetitions)
                        Button(action: {
                            focused = focused?.next(set: set)
                        }) {
                            Image(systemName: "chevron.down")
                        }
                        .disabled([.weight, .right, .duration].contains(focused))
                        Spacer()
                        Button(action: {
                            UIApplication.shared.resignFirstResponder()
                        }) {
                            Text("Done")
                        }
                    }
                }
            }
        }
    }
}
