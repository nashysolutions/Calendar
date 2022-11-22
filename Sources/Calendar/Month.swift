import Foundation

final class Month {
    
    let date: Date
    
    private let calendar: Calendar
    
    private unowned let dataSource: DateRangeSource
    
    lazy var title: String = {
        return Month.dateFormatter.string(from: date)
    }()
    
    init(date: Date, dataSource: DateRangeSource, calendar: Calendar) {
        self.date = date
        self.dataSource = dataSource
        self.calendar = calendar
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    lazy var days: [Day] = {
        var days = [Day]()
        days.append(contentsOf: middleDays)
        days.insert(contentsOf: leadingDays.reversed(), at: 0)
        days.append(contentsOf: trailingDays)
        return days
    }()
    
    private lazy var middleDays: [Day] = {
        var days = [Day]()
        let range = calendar.range(of: .day, in: .month, for: date)!
        let components = calendar.dateComponents([.year, .month], from: date)
        for day in (1...range.count) {
            let date = Date(year: components.year!, month: components.month!, day: day, calendar)
            let isEligible = dataSource.isDateWithinValidRange(date)
            let day = Day(date: date, membership: .current(isEligible), calendar: calendar)
            days.append(day)
        }
        return days
    }()
    
    private lazy var leadingDays: [Day] = {
        var leadingDays = [Day]()
        let leadingDay = middleDays.first!
        var leadingDaysCount = leadingDay.name.leadingDaysCount
        if leadingDaysCount > 0 {
            let previousMonth = calendar.date(byAdding: .month, value: -1, to: leadingDay.date)!
            let range = calendar.range(of: .day, in: .month, for: previousMonth)!
            var components = calendar.dateComponents([.year, .month, .day], from: previousMonth)
            components.day = range.count
            let date = calendar.date(from: components)!
            let eligible = dataSource.isDateWithinValidRange(date)
            let day = Day(date: date, membership: .previous(eligible), calendar: calendar)
            leadingDays.append(day)
            leadingDaysCount -= 1
            for _ in (0..<leadingDaysCount) {
                components.day! -= 1
                let date = calendar.date(from: components)!
                let isWithinRange = dataSource.isDateWithinValidRange(date)
                let day = Day(date: date, membership: .previous(isWithinRange), calendar: calendar)
                leadingDays.append(day)
            }
        }
        return leadingDays
    }()
    
    private lazy var trailingDays: [Day] = {
        var trailingDays = [Day]()
        let trailingDay = middleDays.last!
        var trailingDaysCount = trailingDay.name.trailingDaysCount
        if trailingDaysCount > 0 {
            let nextMonth = calendar.date(byAdding: .month, value: 1, to: trailingDay.date)!
            var components = calendar.dateComponents([.year, .month, .day], from: nextMonth)
            components.day = 1
            let date = calendar.date(from: components)!
            let isWithinRange = dataSource.isDateWithinValidRange(date)
            let day = Day(date: date, membership: .next(isWithinRange), calendar: calendar)
            trailingDays.append(day)
            trailingDaysCount -= 1
            for _ in (0..<trailingDaysCount) {
                components.day! += 1
                let date = calendar.date(from: components)!
                let isWithinRange = dataSource.isDateWithinValidRange(date)
                let day = Day(date: date, membership: .next(isWithinRange), calendar: calendar)
                trailingDays.append(day)
            }
        }
        return trailingDays
    }()
}

extension Month {
    
    /// The source of the day in question, i.e. is the day a member of this month or not.
    /// The boolean associated type explains that the date may not be a member of the eligible date range.
    enum Membership {
        
        case current(Bool)
        case previous(Bool)
        case next(Bool)
        
        /// An elgible date range is one that is within the current month AND within the users selected date range (see `DateRangeSource.swift`).
        var isWithinRange: Bool {
            let children = Mirror(reflecting: self).children
            return children.first!.value as! Bool
        }
    }
}
