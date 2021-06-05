import Foundation

public enum TitlePosition: CaseIterable {
    
    case day
    case month
    
    var identifier: String {
        switch self {
        case .day:
            return "CalendarDayTitleReusableViewID"
        case .month:
            return "CalendarMonthTitleReusableViewID"
        }
    }
}
