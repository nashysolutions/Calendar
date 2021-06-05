import UIKit

final class SummerSnowflakeDisabledDayCell: DisabledDayCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.font = SummerSnowflake.font1
        label.textColor = green
        backgroundView = PathView(type: .day)
        selectedBackgroundView?.backgroundColor = brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
