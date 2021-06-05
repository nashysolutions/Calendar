import UIKit

class DayCell: CollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundView = UIView(frame: bounds)
        accessibilityIdentifier = "dayCell"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
