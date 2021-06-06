import XCTest
@testable import Calendar

final class CalendarTests: XCTestCase {

    func testUserInterfaceMissingForDayPositionInvisible() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.compactMap { position in
            if case .invisible = position {
                return nil
            }
            return SummerSnowflake.userInterface(for: position)
        }
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                switch unwrapped {
                case .missingDayType(at: let position):
                    XCTAssertEqual(DayPosition.invisible, position)
                default:
                    XCTFail("Expecting UserInterface.Error.missingDayType. Actual \(error).")
                }
                XCTAssertTrue(Utility.errorContainsSuitableInformation(unwrapped))
            }
        }
    }
    
    func testUserInterfaceMissingForDayPositionNormal() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.compactMap { position in
            if case .normal = position {
                return nil
            }
            return SummerSnowflake.userInterface(for: position)
        }
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                switch unwrapped {
                case .missingDayType(at: let position):
                    XCTAssertEqual(DayPosition.normal, position)
                default:
                    XCTFail("Expecting UserInterface.Error.missingDayType. Actual \(error).")
                }
            }
        }
    }
    
    func testUserInterfaceMissingForDayPositionDisabled() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.compactMap { position in
            if case .disabled = position {
                return nil
            }
            return SummerSnowflake.userInterface(for: position)
        }
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                switch unwrapped {
                case .missingDayType(at: let position):
                    XCTAssertEqual(DayPosition.disabled, position)
                default:
                    XCTFail("Expecting UserInterface.Error.missingDayType. Actual \(error).")
                }
            }
        }
    }
    
    func testUserInterfaceMissingForDayPositionSpacer() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.compactMap { position in
            if case .spacer = position {
                return nil
            }
            return SummerSnowflake.userInterface(for: position)
        }
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                switch unwrapped {
                case .missingDayType(at: let position):
                    XCTAssertEqual(DayPosition.spacer, position)
                default:
                    XCTFail("Expecting UserInterface.Error.missingDayType. Actual \(error).")
                }
            }
        }
    }
    
    func testLazyLoading() throws {
        
        let calendar = Foundation.Calendar.current
        
        let startDate = Date.distantPast
        let endDate = Date.distantFuture
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.compactMap { position in
            SummerSnowflake.userInterface(for: position)
        }
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        _ = try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )
        
        // do we get this far without hanging?
    }
    
    func testUserInterfaceMultipleForDayPositions1() {
        
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
        
        var dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        dayTypes.insert(SummerSnowflake.userInterface(for: .spacer), at: 0)
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                let condition: Bool
                if case .multipleDayTypes = unwrapped {
                    condition = true
                } else {
                    condition = false
                }
                if condition == false {
                    XCTFail("Expecting UserInterface.Error.multipleDayTypes. Actual \(error).")
                }
                XCTAssertTrue(Utility.errorContainsSuitableInformation(unwrapped))
            }
        }
    }
    
    func testUserInterfaceMultipleForDayPositions2() {
        
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
        
        var dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        dayTypes.insert(SummerSnowflake.userInterface(for: .disabled), at: 0)
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                let condition: Bool
                if case .multipleDayTypes = unwrapped {
                    condition = true
                } else {
                    condition = false
                }
                if condition == false {
                    XCTFail("Expecting UserInterface.Error.multipleDayTypes. Actual \(error).")
                }
            }
        }
    }
    
    func testUserInterfaceMultipleForDayPositions3() {
        
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
        
        var dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        dayTypes.insert(SummerSnowflake.userInterface(for: .spacer), at: 0)
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                let condition: Bool
                if case .multipleDayTypes = unwrapped {
                    condition = true
                } else {
                    condition = false
                }
                if condition == false {
                    XCTFail("Expecting UserInterface.Error.multipleDayTypes. Actual \(error).")
                }
            }
        }
    }
    
    func testUserInterfaceMultipleForDayPositions4() {
        
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
        
        var dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        dayTypes.insert(SummerSnowflake.userInterface(for: .normal), at: 0)
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                let condition: Bool
                if case .multipleDayTypes = unwrapped {
                    condition = true
                } else {
                    condition = false
                }
                if condition == false {
                    XCTFail("Expecting UserInterface.Error.multipleDayTypes. Actual \(error).")
                }
            }
        }
    }
    
    func testUserInterfaceMissingForTitlePositionDay() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let titleTypes: [TitleUserInterfaceCandidate] = TitlePosition.allCases.compactMap { position in
            if case .day = position {
                return nil
            }
            return SummerSnowflake.userInterface(for: position)
        }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                switch unwrapped {
                case .missingTitleType(at: let position):
                    XCTAssertEqual(TitlePosition.day, position)
                default:
                    XCTFail("Expecting UserInterface.Error.missingTitleType. Actual \(error).")
                }
                XCTAssertTrue(Utility.errorContainsSuitableInformation(unwrapped))
            }
        }
    }
    
    func testUserInterfaceMissingForTitlePositionMonth() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let titleTypes: [TitleUserInterfaceCandidate] = TitlePosition.allCases.compactMap { position in
            if case .month = position {
                return nil
            }
            return SummerSnowflake.userInterface(for: position)
        }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                switch unwrapped {
                case .missingTitleType(at: let position):
                    XCTAssertEqual(TitlePosition.month, position)
                default:
                    XCTFail("Expecting UserInterface.Error.missingTitleType. Actual \(error).")
                }
            }
        }
    }
    
    func testUserInterfaceMultipleForTitlePositions1() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        var titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        titleTypes.insert(SummerSnowflake.userInterface(for: .day), at: 0)
        
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                let condition: Bool
                if case .multipleTitleTypes = unwrapped {
                    condition = true
                } else {
                    condition = false
                }
                if condition == false {
                    XCTFail("Expecting UserInterface.Error.multipleTitleTypes. Actual \(error).")
                }
                XCTAssertTrue(Utility.errorContainsSuitableInformation(unwrapped))
            }
        }
    }
    
    func testUserInterfaceMultipleForTitlePositions2() {
        
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
        
        let dayTypes: [DayUserInterfaceCandidate] = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        var titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        titleTypes.insert(SummerSnowflake.userInterface(for: .month), at: 0)
        
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        XCTAssertThrowsError(try PagingGridView(
            dates: startDate...endDate,
            userInterface: userInterface,
            calendar: calendar
        )) { (error) in
            switch error as? UserInterface.Error {
            case .none:
                XCTFail("Expecting UserInterface.Error. Actual \(error).")
            case .some(let unwrapped):
                let condition: Bool
                if case .multipleTitleTypes = unwrapped {
                    condition = true
                } else {
                    condition = false
                }
                if condition == false {
                    XCTFail("Expecting UserInterface.Error.multipleTitleTypes. Actual \(error).")
                }
            }
        }
    }

    func testPerformancePagingGridViewInit() {
        
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
        
        let dayTypes = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        
        self.measure {
            _ = try! PagingGridView(
                    dates: startDate...endDate,
                    userInterface: userInterface,
                    calendar: calendar
            )
        }
    }
}
