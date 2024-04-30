//
//  UIApplication+Swool.swift
//  swool
//
//  Created by Alex Young on 4/30/24.
//

import UIKit

extension UIApplication {

    func resignFirstResponder() {
        self.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
