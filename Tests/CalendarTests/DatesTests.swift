import XCTest
@testable import Calendar

final class DatesTests: XCTestCase {
    
    func testDatesOrderedSame() throws {
        
        let calendar = Foundation.Calendar.current
        
        let startYear: Int = 2018
        let startMonth: Int = 7
        let startDay: Int = 25
        var components = DateComponents()
        components.year = startYear
        components.month = startMonth
        components.day = startDay
        guard let startDate = calendar.date(from: components) else {
            return XCTFail()
        }
        
        let endYear: Int = 2018
        let endMonth: Int = 7
        let endDay: Int = 25
        components.year = endYear
        components.month = endMonth
        components.day = endDay
        guard let endDate = calendar.date(from: components) else {
            return XCTFail()
        }
        
        XCTAssertThrowsError(try Dates(range: startDate...endDate).validate(calendar: calendar)
        ) { (error) in
            let expecting = Dates.Error.minimumGranularity
            XCTAssertEqual(error as? Dates.Error, expecting)
        }
    }
    
    func testDatesMinimumGranularity() {
        
        let calendar = Foundation.Calendar.current
        
        let startYear: Int = 2018
        let startMonth: Int = 7
        let startDay: Int = 25
        var components = DateComponents()
        components.year = startYear
        components.month = startMonth
        components.day = startDay
        guard let startDate = calendar.date(from: components) else {
            return XCTFail()
        }
        
        let endYear: Int = 2018
        let endMonth: Int = 7
        let endDay: Int = 26
        components.year = endYear
        components.month = endMonth
        components.day = endDay
        guard let endDate = calendar.date(from: components) else {
            return XCTFail()
        }
        
        let adjustedEndDate = calendar.date(byAdding: DateComponents(hour: -1), to: endDate)!
        
        XCTAssertThrowsError(try Dates(range: startDate...adjustedEndDate).validate(calendar: calendar)
        ) { (error) in
            let expecting = Dates.Error.minimumGranularity
            XCTAssertEqual(error as? Dates.Error, expecting)
            XCTAssertTrue(Utility.errorContainsSuitableInformation(error))
        }
    }
    
    func testDatesValidDateRange() {
        
        let calendar = Foundation.Calendar.current
        
        let startYear: Int = 2018
        let startMonth: Int = 7
        let startDay: Int = 25
        var components = DateComponents()
        components.year = startYear
        components.month = startMonth
        components.day = startDay
        guard let startDate = calendar.date(from: components) else {
            return XCTFail()
        }
        
        let endYear: Int = 2018
        let endMonth: Int = 7
        let endDay: Int = 26
        components.year = endYear
        components.month = endMonth
        components.day = endDay
        guard let endDate = calendar.date(from: components) else {
            return XCTFail()
        }
        
        XCTAssertNoThrow(try Dates(range: startDate...endDate).validate(calendar: calendar))
    }
}
