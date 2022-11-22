import Foundation

public struct DayUserInterfaceCandidate {
    
    let dayButtonState: DayButtonState
    let view: DayUserInterface.Type
    
    public init(dayButtonState: DayButtonState, view: DayUserInterface.Type) {
        self.dayButtonState = dayButtonState
        self.view = view
    }
}
