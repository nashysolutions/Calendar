import UIKit

public protocol DayUserInterface: UICollectionViewCell {
    var label: UILabel { get }
}

extension DayUserInterface {
    
    func update(with unit: Day, calendar: Calendar) {
        label.text = String(unit.calendarUnit)
        guard accessibilityIdentifier != nil else {
            return
        }
        if let first = accessibilityIdentifier!.components(separatedBy: " ").first {
            accessibilityIdentifier = first + " " + unit.accessibilityIdentifierSuffix(calendar)
        } else {
            accessibilityIdentifier = accessibilityIdentifier! + " " + unit.accessibilityIdentifierSuffix(calendar)
        }
    }
}

extension UICollectionView {
    
    func register(_ dayTypes: [DayUserInterfaceCandidate]) {
        for dayType in dayTypes {
            let userInterface = dayType.view
            let identifier = dayType.dayButtonState.rawValue
            register(userInterface as UICollectionViewCell.Type, forCellWithReuseIdentifier: identifier)
        }
    }
}

extension Array where Element == DayUserInterfaceCandidate {
    
    func validate() throws {
        let counts = reduce(into: [:]) { accumulation, dayType in
            accumulation[dayType.dayButtonState, default: 0] += 1
        }
        for state in DayButtonState.allCases {
            let frequency = counts[state]
            if frequency == nil || frequency == 0 {
                throw UserInterface.Error.missingDayType(for: state)
            } else if frequency! > 1 {
                throw UserInterface.Error.multipleDayTypes
            }
        }
    }
}
