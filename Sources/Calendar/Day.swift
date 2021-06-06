import Foundation

public final class Day {
    
    private let calendar: Calendar
    
    lazy var calendarUnit: Int = {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }()
    
    let date: Date
    
    func accessibilityIdentifierSuffix(_ calendar: Calendar = .current) -> String {
        let components = calendar.dateComponents([.day, .month], from: date)
        return "\(components.month!).\(components.day!)"
    }
    
    let membership: Month.Membership
    
    lazy var name = Day.Name(date: date)
        
    init(date: Date, membership: Month.Membership, calendar: Calendar) {
        self.date = date
        self.membership = membership
        self.calendar = calendar
    }
}

extension Day {
    
    enum Name: String {
        
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
        
        var index: Int {
            switch self {
            case .monday:
                return 1
            case .tuesday:
                return 2
            case .wednesday:
                return 3
            case .thursday:
                return 4
            case .friday:
                return 5
            case .saturday:
                return 6
            case .sunday:
                return 7
            }
        }
        
        public init?(index: Int) {
            switch index {
            case 1:
                self = .monday
            case 2:
                self = .tuesday
            case 3:
                self = .wednesday
            case 4:
                self = .thursday
            case 5:
                self = .friday
            case 6:
                self = .saturday
            case 7:
                self = .sunday
            default:
                return nil
            }
        }
        
        init(date: Date) {
            let rawValue = Day.Name.dateFormatter.string(from: date)
            self = Day.Name(rawValue: rawValue)!
        }
        
        var isBeginning: Bool {
            if case .monday = self {
                return true
            }
            return false
        }
        
        public var shortName: String {
            return String(rawValue.prefix(3))
        }
        
        var leadingDaysCount: Int {
            return index - 1
        }
        
        var trailingDaysCount: Int {
            return Day.Name.sunday.index - index
        }
        
        private static let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter
        }()
    }
}

extension Day: Equatable {
    
    public static func ==(lhs: Day, rhs: Day) -> Bool {
        return lhs.date == rhs.date
    }
}
