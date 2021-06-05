import UIKit

final class PathView: UIView {
    
    enum CellType {
        case day
        case spacer
    }
    
    private var type: CellType = .day
    
    init(type: CellType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let backgroundColor: UIColor
        let lineColor: UIColor
        switch type {
        case .day:
            backgroundColor = SummerSnowflake.black
            lineColor = red
        case .spacer:
            backgroundColor = SummerSnowflake.shade
            lineColor = red
        }
        backgroundColor.setFill()
        UIRectFill(rect)
        lineColor.setStroke()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.lineWidth = 3
        path.stroke()
    }
}
