import UIKit

final class SummerSnowflakeDayCell: DayCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.font = SummerSnowflake.font1
        label.textColor = green
        backgroundView?.backgroundColor = red
        selectedBackgroundView?.backgroundColor = brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? red : green
        }
    }
}
