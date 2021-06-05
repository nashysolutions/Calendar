import UIKit

public struct UserInterface {
    
    public enum Error: Swift.Error {
        case missingDayType(at: DayPosition)
        case multipleDayTypes
        case missingTitleType(at: TitlePosition)
        case multipleTitleTypes
    }
    
    /// The padding around each cell
    public var padding: CGFloat = 5
    
    /// The height of the month title
    public var monthHeaderHeight: CGFloat = 50
    
    /// The height of each section header
    public var dayHeaderHeight: CGFloat = 35
    
    let dayTypes: [DayUserInterfaceCandidate]
    let titleTypes: [TitleUserInterfaceCandidate]
    
    public init(dayTypes: [DayUserInterfaceCandidate], titleTypes: [TitleUserInterfaceCandidate]) {
        self.dayTypes = dayTypes
        self.titleTypes = titleTypes
    }
    
    func validate() throws {
        try dayTypes.validate()
        try titleTypes.validate()
    }
}

extension UserInterface.Error: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .missingDayType(let position):
            return "A UI element must be provided for the position represented by '\(position)'. See documentation for more details."
        case .multipleDayTypes:
            return "Multiple UI elements have been provided for a single position. See documentation for more details."
        case .missingTitleType(let position):
            return "A UI element must be provided for the position represented by '\(position)'. See documentation for more details."
        case .multipleTitleTypes:
            return "Multiple UI elements have been provided for a single position. See documentation for more details."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .missingDayType(let position):
            return "A UI element is missing for the position represented by '\(position)'. See documentation for more details."
        case .multipleDayTypes:
            return "Unable to determine which of the provided UI elements is to be used."
        case .missingTitleType(let position):
            return "A UI element is missing for the position represented by '\(position)'. See documentation for more details."
        case .multipleTitleTypes:
            return "Unable to determine which of the provided UI elements is to be used."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .missingDayType(let position):
            return "Provide a UI element which represents the position '\(position)'. See documentation for more details."
        case .multipleDayTypes:
            return "Provide a single UI element for each position, instead of multiple UI elements."
        case .missingTitleType(let position):
            return "Provide a UI element which represents the position '\(position)'. See documentation for more details."
        case .multipleTitleTypes:
            return "Provide a single UI element, instead of multiple UI elements."
        }
    }
}
