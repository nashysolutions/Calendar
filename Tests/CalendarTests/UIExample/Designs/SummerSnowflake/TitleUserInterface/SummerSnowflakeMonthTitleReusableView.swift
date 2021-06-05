import UIKit
import Calendar

class SummerSnowflakeMonthTitleReusableView: MonthTitleReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = green
        label.font = SummerSnowflake.font3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
