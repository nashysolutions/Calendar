import UIKit

final class SummerSnowflakeDayTitleReusableView: DayTitleReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = green
        label.font = SummerSnowflake.font2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
