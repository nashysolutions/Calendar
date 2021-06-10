import Foundation

public struct Dates {
    
    let startDate: Date
    let endDate: Date
    
    public enum Error: Swift.Error {
        case minimumGranularity
        case couldNotCalculate
    }
    
    public init(range: ClosedRange<Date>, calendar: Foundation.Calendar) throws {
        let startDate = range.lowerBound
        let endDate = range.upperBound
        guard let startMidnight = calendar.dateInterval(of: .day, for: startDate)?.start else {
            throw Error.couldNotCalculate
        }
        guard let endMidnight = calendar.dateInterval(of: .day, for: endDate)?.start else {
            throw Error.couldNotCalculate
        }
        if startMidnight.compare(endMidnight) == .orderedSame {
            throw Error.minimumGranularity
        }
        let range = calendar.dateComponents([.day], from: startMidnight, to: endMidnight)
        let days = range.day ?? 0
        if days < 1 {
            throw Error.minimumGranularity
        }
        self.startDate = startMidnight
        self.endDate = endMidnight
    }
}

extension Dates.Error: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .minimumGranularity:
            return "The date range does not span, at the very least, a 24 hour period."
        case .couldNotCalculate:
            return "A date calculation could not be determined."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .minimumGranularity:
            return "The date range is not wide enough to support a single day."
        case .couldNotCalculate:
            return "Midnight could not be calculated."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .minimumGranularity:
            return "Provide a wider date range that spans a single day or more, so that the user has at least one selection to make in the UI."
        case .couldNotCalculate:
            return "Please ensure a day component is provided."
        }
    }
}
