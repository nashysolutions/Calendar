import Foundation

extension Date {
    
    init(year: Int, month: Int, day: Int, _ calendar: Foundation.Calendar = .current) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        self = calendar.date(from: components)!
    }
    
    init(year: Int, month: Int, _ calendar: Foundation.Calendar = .current) {
        var components = DateComponents()
        components.year = year
        components.month = month
        self = calendar.date(from: components)!
    }
    
    func startOfMonth(_ calendar: Foundation.Calendar = .current) -> Date {
        calendar.dateInterval(of: .month, for: self)!.start
    }
}
