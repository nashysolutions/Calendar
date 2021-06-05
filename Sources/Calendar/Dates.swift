import Foundation

public struct Dates {
    
    let startDate: Date
    let endDate: Date
    
    public enum Error: Swift.Error {
        case minimumGranularity
    }
    
    public init(range: ClosedRange<Date>) {
        self.startDate = range.lowerBound
        self.endDate = range.upperBound
    }
    
    func validate(calendar: Foundation.Calendar) throws {
        if startDate.compare(endDate) == .orderedSame {
            throw Error.minimumGranularity
        }
        let range = calendar.dateComponents([.day], from: startDate, to: endDate)
        let days = range.day ?? 0
        if days < 1 {
            throw Error.minimumGranularity
        }
    }
}

extension Dates.Error: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .minimumGranularity:
            return "The date range does not span, at the very least, a 24 hour period."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .minimumGranularity:
            return "The date range is not wide enough to support a single day."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .minimumGranularity:
            return "Provide a wider date range that spans a single day or more, so that the user has at least one selection to make in the UI."
        }
    }
}
