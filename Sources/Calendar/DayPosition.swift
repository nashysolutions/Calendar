import Foundation

public enum DayPosition: String, CaseIterable {
    
    case spacer
    case disabled
    case invisible
    case normal
    
    var identifier: String {
        return rawValue
    }
    
    static func position(for day: Day) -> DayPosition {
        switch day.membership {
        case .current(let selection):
            switch selection {
            case .withinRange:
                return .normal
            case .outsideRange:
                return .disabled
            }
        case .next(let selection):
            switch selection {
            case .withinRange:
                return .spacer
            case .outsideRange:
                return .invisible
            }
        case .previous(let selection):
            switch selection {
            case .withinRange:
                return .spacer
            case .outsideRange:
                return .invisible
            }
        case .none:
            return .invisible
        }
    }
}
