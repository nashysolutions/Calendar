import UIKit

class SpacerDayCell: CollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundView = UIView(frame: bounds)
        accessibilityIdentifier = "spacerDayCell"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
