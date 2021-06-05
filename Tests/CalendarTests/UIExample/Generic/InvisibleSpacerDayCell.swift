import UIKit

final class InvisibleSpacerDayCell: CollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        accessibilityIdentifier = "invisibleSpacerDayCell"
        label.textColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
