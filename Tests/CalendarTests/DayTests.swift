import XCTest
@testable import Calendar

final class DayTests: XCTestCase {
    
    func testMonday() {
        let index: Int = 1
        switch Day.Name(index: index) {
        case .none:
            XCTFail()
        case .some(let monday):
            XCTAssertEqual(monday, Day.Name.monday)
            XCTAssertEqual(monday.index, index)
            XCTAssertTrue(monday.isBeginning)
            XCTAssertEqual(monday.rawValue, "Monday")
            XCTAssertEqual(monday.shortName, "Mon")
            XCTAssertEqual(monday.leadingDaysCount, 0)
            XCTAssertEqual(monday.trailingDaysCount, 6)
        }
        let calendar = Calendar.current
        let date = Date(year: 2019, month: 4, day: 22, calendar)
        XCTAssertEqual(Day.Name(date: date), Day.Name.monday)
        let day = Day(date: date, membership: .current(true), calendar: calendar)
        checkCalendarUnit(day, calendar)
        checkAccessibilityIdentifier(day, calendar)
    }
    
    func testTuesday() {
        let index: Int = 2
        switch Day.Name(index: index) {
        case .none:
            XCTFail()
        case .some(let tuesday):
            XCTAssertEqual(tuesday, Day.Name.tuesday)
            XCTAssertEqual(tuesday.index, index)
            XCTAssertFalse(tuesday.isBeginning)
            XCTAssertEqual(tuesday.rawValue, "Tuesday")
            XCTAssertEqual(tuesday.shortName, "Tue")
            XCTAssertEqual(tuesday.leadingDaysCount, 1)
            XCTAssertEqual(tuesday.trailingDaysCount, 5)
        }
        let calendar = Calendar.current
        let date = Date(year: 2019, month: 4, day: 23, calendar)
        XCTAssertEqual(Day.Name(date: date), Day.Name.tuesday)
        let day = Day(date: date, membership: .current(true), calendar: calendar)
        checkCalendarUnit(day, calendar)
        checkAccessibilityIdentifier(day, calendar)
    }
    
    func testWednesday() {
        let index: Int = 3
        switch Day.Name(index: index) {
        case .none:
            XCTFail()
        case .some(let wednesday):
            XCTAssertEqual(wednesday, Day.Name.wednesday)
            XCTAssertEqual(wednesday.index, index)
            XCTAssertFalse(wednesday.isBeginning)
            XCTAssertEqual(wednesday.rawValue, "Wednesday")
            XCTAssertEqual(wednesday.shortName, "Wed")
            XCTAssertEqual(wednesday.leadingDaysCount, 2)
            XCTAssertEqual(wednesday.trailingDaysCount, 4)
        }
        let calendar = Calendar.current
        let date = Date(year: 2019, month: 4, day: 24, calendar)
        XCTAssertEqual(Day.Name(date: date), Day.Name.wednesday)
        let day = Day(date: date, membership: .current(true), calendar: calendar)
        checkCalendarUnit(day, calendar)
        checkAccessibilityIdentifier(day, calendar)
    }
    
    func testThursday() {
        let index: Int = 4
        switch Day.Name(index: index) {
        case .none:
            XCTFail()
        case .some(let thursday):
            XCTAssertEqual(thursday, Day.Name.thursday)
            XCTAssertEqual(thursday.index, index)
            XCTAssertFalse(thursday.isBeginning)
            XCTAssertEqual(thursday.rawValue, "Thursday")
            XCTAssertEqual(thursday.shortName, "Thu")
            XCTAssertEqual(thursday.leadingDaysCount, 3)
            XCTAssertEqual(thursday.trailingDaysCount, 3)
        }
        let calendar = Calendar.current
        let date = Date(year: 2019, month: 4, day: 25, calendar)
        XCTAssertEqual(Day.Name(date: date), Day.Name.thursday)
        let day = Day(date: date, membership: .current(true), calendar: calendar)
        checkCalendarUnit(day, calendar)
        checkAccessibilityIdentifier(day, calendar)
    }
    
    func testFriday() {
        let index: Int = 5
        switch Day.Name(index: index) {
        case .none:
            XCTFail()
        case .some(let friday):
            XCTAssertEqual(friday, Day.Name.friday)
            XCTAssertEqual(friday.index, index)
            XCTAssertFalse(friday.isBeginning)
            XCTAssertEqual(friday.rawValue, "Friday")
            XCTAssertEqual(friday.shortName, "Fri")
            XCTAssertEqual(friday.leadingDaysCount, 4)
            XCTAssertEqual(friday.trailingDaysCount, 2)
        }
        let calendar = Calendar.current
        let date = Date(year: 2019, month: 4, day: 26, calendar)
        XCTAssertEqual(Day.Name(date: date), Day.Name.friday)
        let day = Day(date: date, membership: .current(true), calendar: calendar)
        checkCalendarUnit(day, calendar)
        checkAccessibilityIdentifier(day, calendar)
    }
    
    func testSaturday() {
        let index: Int = 6
        switch Day.Name(index: index) {
        case .none:
            XCTFail()
        case .some(let saturday):
            XCTAssertEqual(saturday, Day.Name.saturday)
            XCTAssertEqual(saturday.index, index)
            XCTAssertFalse(saturday.isBeginning)
            XCTAssertEqual(saturday.rawValue, "Saturday")
            XCTAssertEqual(saturday.shortName, "Sat")
            XCTAssertEqual(saturday.leadingDaysCount, 5)
            XCTAssertEqual(saturday.trailingDaysCount, 1)
        }
        let calendar = Calendar.current
        let date = Date(year: 2019, month: 4, day: 27, calendar)
        XCTAssertEqual(Day.Name(date: date), Day.Name.saturday)
        let day = Day(date: date, membership: .current(true), calendar: calendar)
        checkCalendarUnit(day, calendar)
        checkAccessibilityIdentifier(day, calendar)
    }
    
    func testSunday() {
        let index: Int = 7
        switch Day.Name(index: index) {
        case .none:
            XCTFail()
        case .some(let sunday):
            XCTAssertEqual(sunday, Day.Name.sunday)
            XCTAssertEqual(sunday.index, index)
            XCTAssertFalse(sunday.isBeginning)
            XCTAssertEqual(sunday.rawValue, "Sunday")
            XCTAssertEqual(sunday.shortName, "Sun")
            XCTAssertEqual(sunday.leadingDaysCount, 6)
            XCTAssertEqual(sunday.trailingDaysCount, 0)
        }
        let calendar = Calendar.current
        let date = Date(year: 2019, month: 4, day: 28, calendar)
        XCTAssertEqual(Day.Name(date: date), Day.Name.sunday)
        let day = Day(date: date, membership: .current(true), calendar: calendar)
        checkCalendarUnit(day, calendar)
        checkAccessibilityIdentifier(day, calendar)
    }
    
    private func checkCalendarUnit(_ day: Day, _ calendar: Calendar) {
        let components = calendar.dateComponents([.day], from: day.date)
        XCTAssertEqual(day.calendarUnit, components.day)
    }
    
    private func checkAccessibilityIdentifier(_ day: Day, _ calendar: Calendar) {
        let components = calendar.dateComponents([.day, .month], from: day.date)
        let matching = "\(components.month!).\(components.day!)"
        XCTAssertEqual(day.accessibilityIdentifierSuffix(calendar), matching)
    }
}
