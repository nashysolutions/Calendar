import UIKit
import Calendar

struct SummerSnowflake {
    
    static let font1 = UIFont(name: "AvenirNext-Regular", size: (UIScreen.main.bounds.width == 320) ? 18 : 20)!
    static let font2 = UIFont(name: "AvenirNext-Medium", size: (UIScreen.main.bounds.width == 320) ? 14 : 16)!
    static let font3 = UIFont(name: "AvenirNext-Medium", size: (UIScreen.main.bounds.width == 320) ? 24 : 30)!
    
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let shade = black.withAlphaComponent(0.1)
    
    static func userInterface(for position: DayPosition) -> DayUserInterfaceCandidate {
        let userInterface: DayUserInterface.Type
        switch position {
        case .invisible:
            userInterface = InvisibleSpacerDayCell.self
        case .disabled:
            userInterface = SummerSnowflakeDisabledDayCell.self
        case .spacer:
            userInterface = SummerSnowflakeSpacerDayCell.self
        case .normal:
            userInterface = SummerSnowflakeDayCell.self
        }
        return DayUserInterfaceCandidate(position: position, view: userInterface)
    }
    
    static func userInterface(for position: TitlePosition) -> TitleUserInterfaceCandidate {
        let userInterface: TitleUserInterface.Type
        switch position {
        case .day:
            userInterface = SummerSnowflakeDayTitleReusableView.self
        case .month:
            userInterface = SummerSnowflakeMonthTitleReusableView.self
        }
        return TitleUserInterfaceCandidate(position: position, view: userInterface)
    }
}
