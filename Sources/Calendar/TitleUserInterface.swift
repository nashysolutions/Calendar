import UIKit

public protocol TitleUserInterface: UICollectionReusableView {
    var label: UILabel { get }
}

extension TitleUserInterface {
    
    func update(with title: String) {
        label.text = title
    }
}

extension UICollectionView {
    
    func register(_ titleTypes: [TitleUserInterfaceCandidate]) {
        for titleType in titleTypes {
            let userInterface = titleType.view
            let position = titleType.position
            register(userInterface as UICollectionReusableView.Type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: position.identifier)
        }
    }
}

extension Array where Element == TitleUserInterfaceCandidate {
    
    func validate() throws {
        let counts = reduce(into: [:]) { accumulation, titleType in
            accumulation[titleType.position, default: 0] += 1
        }
        for position in TitlePosition.allCases {
            let frequency = counts[position]
            if frequency == nil || frequency == 0 {
                throw UserInterface.Error.missingTitleType(at: position)
            } else if frequency! > 1 {
                throw UserInterface.Error.multipleTitleTypes
            }
        }
    }
}
