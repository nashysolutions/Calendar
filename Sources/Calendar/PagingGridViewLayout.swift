import UIKit

protocol PagingGridViewLayoutDataSource: AnyObject {
    func pagingGridViewLayoutLongestMonth(_ layout: PagingGridViewLayout) -> Month
}

final class PagingGridViewLayout: UICollectionViewLayout {
    
    weak var dataSource: PagingGridViewLayoutDataSource?
    
    private let padding: CGFloat
    private let dayHeaderHeight: CGFloat
    private let monthHeaderHeight: CGFloat
    private let daysPerWeek: Int = 7
    
    convenience init(userInterface: UserInterface) {
        let padding = userInterface.padding
        let monthHeaderHeight = userInterface.monthHeaderHeight
        let dayHeaderHeight = userInterface.dayHeaderHeight
        self.init(padding: padding, monthHeaderHeight: monthHeaderHeight, dayHeaderHeight: dayHeaderHeight)
    }
    
    private init(padding: CGFloat, monthHeaderHeight: CGFloat, dayHeaderHeight: CGFloat) {
        self.padding = padding
        self.monthHeaderHeight = monthHeaderHeight
        self.dayHeaderHeight = dayHeaderHeight
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cellWidth: CGFloat {
        guard let collectionView = collectionView else {
            preconditionFailure()
        }
        return collectionView.bounds.width / CGFloat(daysPerWeek)
    }
    
    private var insets: UIEdgeInsets {
        guard let collectionView = collectionView else {
            preconditionFailure()
        }
        return collectionView.contentInset
    }
    
    private var monthHeaderWidth: CGFloat {
        guard let collectionView = collectionView else {
            preconditionFailure()
        }
        return collectionView.bounds.width
    }
    
    private var cellHeight: CGFloat {
        return cellWidth
    }
    
    private func indexPathsOfItemsInRect(in rect: CGRect) -> [IndexPath] {
        var collector = [IndexPath]()
        for column in columnRange(forRect: rect) {
            let section = self.section(forColumn: column)
            for row in rowRange(forRect: rect, inSection: section) {
                if let item = item(forColumn: column, forRow: row, inSection: section) {
                    let indexPath = IndexPath(item: item, section: section)
                    collector.append(indexPath)
                }
            }
        }
        return collector
    }
    
    private func item(forColumn column: Int, forRow row: Int, inSection section: Int) -> Int? {
        guard let collectionView = collectionView as? PagingGridView else {
            preconditionFailure()
        }
        let month = collectionView.month(at: section)
        let count = month.days.count
        let item = row * daysPerWeek + (column % daysPerWeek)
        if item < count {
            return item
        }
        return nil
    }
    
    private func section(forColumn column: Int) -> Int {
        guard let collectionView = collectionView as? PagingGridView else {
            preconditionFailure()
        }
        let section = Int(floor(CGFloat(column) / CGFloat(daysPerWeek)))
        return min(collectionView.totalMonths - 1, section)
    }
    
    private func indexPathsOfSupplementaryViewsInRect(in rect: CGRect) -> [IndexPath] {
        var collector = [IndexPath]()
        let monthHeaderIndexPath = IndexPath(row: 0, section: 0)
        collector.append(monthHeaderIndexPath)
        for column in columnRange(forRect: rect) {
            let indexPath = IndexPath(item: (column % daysPerWeek) + 1, section: 0)
            collector.append(indexPath)
        }
        return collector
    }
    
    private func rowRange(forRect rect: CGRect, inSection section: Int) -> CountableClosedRange<Int> {
        let lowerBound = row(forY: rect.minY)
        let upperBound = min(row(forY: rect.maxY), totalRows(forSection: section))
        return lowerBound...upperBound
    }
    
    private func totalRows(forSection section: Int) -> Int {
        guard let collectionView = collectionView as? PagingGridView else {
            preconditionFailure()
        }
        let month = collectionView.month(at: section)
        let days = month.days.count
        return totalRows(for: days)
    }
    
    private func totalRows(for days: Int) -> Int {
        let rows: CGFloat = CGFloat(days) / CGFloat(daysPerWeek)
        return Int(ceil(rows))
    }
    
    private func columnRange(forRect rect: CGRect) -> CountableClosedRange<Int> {
        let lowerBound = column(forX: rect.minX)
        let upperBound = column(forX: rect.maxX)
        return lowerBound...upperBound
    }
    
    private func column(forX x: CGFloat) -> Int {
        return Int(floor(max(0, x / cellWidth)))
    }
    
    private func row(forY y: CGFloat) -> Int {
        return Int(floor(max(0, y - dayHeaderHeight - monthHeaderHeight) / cellHeight))
    }
    
    private func column(forIndexPath indexPath: IndexPath) -> Int {
        return (indexPath.item % daysPerWeek) + (daysPerWeek * indexPath.section)
    }
    
    private func row(forIndexPath indexPath: IndexPath) -> Int {
        return Int(floor(CGFloat(indexPath.item) / CGFloat(daysPerWeek)))
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView as? PagingGridView else {
            preconditionFailure()
        }
        let totalMonths = collectionView.totalMonths
        let columns = totalMonths * daysPerWeek
        let month = dataSource!.pagingGridViewLayoutLongestMonth(self)
        let mostRows = totalRows(for: month.days.count)
        let width = (CGFloat(columns) * cellWidth) - (insets.left + insets.right)
        let height = (CGFloat(mostRows) * cellHeight) - (insets.top + insets.bottom) + monthHeaderHeight + dayHeaderHeight
        return CGSize(width: width, height: height)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let itemAttributes = indexPathsOfItemsInRect(in: rect).compactMap {
            return layoutAttributesForItem(at: $0)
        }
        let sectionHeaderAttributes = indexPathsOfSupplementaryViewsInRect(in: rect).compactMap {
            return layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: $0)
        }
        return itemAttributes + sectionHeaderAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let column: Int = self.column(forIndexPath: indexPath)
        let x: CGFloat = CGFloat(column) * cellWidth
        let row: Int = self.row(forIndexPath: indexPath)
        let y: CGFloat = (CGFloat(row) * cellHeight) + monthHeaderHeight + dayHeaderHeight
        let frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
        attributes.frame = frame.insetBy(dx: padding, dy: padding)
        attributes.zIndex = 0
        return attributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        let x: CGFloat
        let y: CGFloat
        let width: CGFloat
        let height: CGFloat
        if indexPath.item == 0 { // month title view
            x = collectionView!.contentOffset.x
            y = collectionView!.contentOffset.y + insets.top
            width = monthHeaderWidth
            height = monthHeaderHeight
        } else { // day of week title view
            x = CGFloat(indexPath.item - 1) * cellWidth + collectionView!.contentOffset.x
            y = collectionView!.contentOffset.y + monthHeaderHeight + insets.top
            width = cellWidth
            height = dayHeaderHeight
        }
        let frame = CGRect(x: x, y: y, width: width, height: height)
        attributes.frame = frame.insetBy(dx: padding, dy: padding)
        attributes.zIndex = 1
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
