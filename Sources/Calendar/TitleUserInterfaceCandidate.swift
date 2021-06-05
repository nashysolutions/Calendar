import Foundation

public struct TitleUserInterfaceCandidate {
    
    let position: TitlePosition
    let view: TitleUserInterface.Type
    
    public init(position: TitlePosition, view: TitleUserInterface.Type) {
        self.position = position
        self.view = view
    }
}
