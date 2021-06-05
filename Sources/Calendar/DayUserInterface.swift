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
            let position = dayType.position
            register(userInterface as UICollectionViewCell.Type, forCellWithReuseIdentifier: position.identifier)
        }
    }
}

extension Array where Element == DayUserInterfaceCandidate {
    
    func validate() throws {
        let counts = reduce(into: [:]) { accumulation, dayType in
            accumulation[dayType.position, default: 0] += 1
        }
        for position in DayPosition.allCases {
            let frequency = counts[position]
            if frequency == nil || frequency == 0 {
                throw UserInterface.Error.missingDayType(at: position)
            } else if frequency! > 1 {
                throw UserInterface.Error.multipleDayTypes
            }
        }
    }
}
