import Foundation

public struct DayUserInterfaceCandidate {
    
    let position: DayPosition
    let view: DayUserInterface.Type
    
    public init(position: DayPosition, view: DayUserInterface.Type) {
        self.position = position
        self.view = view
    }
}
