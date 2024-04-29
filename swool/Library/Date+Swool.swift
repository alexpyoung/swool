//
//  Date+Swool.swift
//  swool
//
//  Created by Alex Young on 4/29/24.
//

import Foundation
import SwiftUI

extension Date {

    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    var isWithinAWeek: Bool {
        let now = Date()
        return self < now && self > Calendar.current.date(byAdding: .day, value: -7, to: now)!
    }
    var isThisMonth: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    var isThisYear: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    // https://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
    func humanReadable() -> String {
        if self.isToday {
            return self.format("'Today at 'h:mm a")
        } else if self.isYesterday {
            return self.format("'Yesterday at 'h:mm a")
        } else if self.isWithinAWeek {
            return self.format("EEEE 'at' h:mm a")
        } else if self.isThisYear {
            return self.format("EEE, MMM dd, h:mm a")
        } else {
            return self.format("MM/dd/yy, h:mm a ")
        }
    }
}

private struct DateView: View {
    private let dates: [Date?] = [
        Date(),
        Calendar.current.date(byAdding: .day, value: -1, to: Date()),
        Calendar.current.date(byAdding: .day, value: -6, to: Date()),
        Calendar.current.date(byAdding: .month, value: -1, to: Date()),
        Calendar.current.date(byAdding: .year, value: -1, to: Date()),
    ]
    var body: some View {
        VStack {
            List {
                ForEach(dates.compactMap { $0 }, id: \.description) { date in
                    Text(date.humanReadable())
                }
            }
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView()
    }
}
