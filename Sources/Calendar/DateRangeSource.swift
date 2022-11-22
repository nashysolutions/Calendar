//
//  DateRangeSource.swift
//  
//
//  Created by Robert Nash on 08/06/2021.
//

import Foundation

protocol DateRangeSource: AnyObject {
    var startDate: Date { get }
    var endDate: Date { get }
}

extension DateRangeSource {
    
    /// Determine whether the provided date is suitable for this month.
    /// - Parameter date: The subject under investigation.
    /// - Returns: If this date is within the range of the current month.
    func isDateWithinValidRange(_ date: Date) -> Bool {
        switch date.compare(startDate) {
        case .orderedAscending:
            return false
        case .orderedDescending:
            switch date.compare(endDate) {
            case .orderedAscending, .orderedSame:
                return true
            case .orderedDescending:
                return false
            }
        case .orderedSame:
            return true
        }
    }
}
