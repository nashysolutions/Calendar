import UIKit

class DisabledDayCell: CollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        accessibilityIdentifier = "disabledDayCell"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
