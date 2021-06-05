import UIKit

public class PagingGridView: UICollectionView {
    
    private let model: PagingGridViewModel
    
    var months: [Month] {
        return model.months
    }
    
    public var currentSelection: Day? {
        return model.currentSelection
    }
    
    public var canPageToPrevious: Bool {
        return model.canPageToPrevious
    }
    
    public var canPageToNext: Bool {
        return model.canPageToNext
    }
    
    public init(dates: ClosedRange<Date>, userInterface: UserInterface, calendar: Calendar = .current) throws {
        
        let dates = Dates(range: dates)
        try dates.validate(calendar: calendar)
        
        try userInterface.validate()
        
        model = PagingGridViewModel(dates: dates, calendar: calendar)
        
        let layout = PagingGridViewLayout(userInterface: userInterface)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        model.collectionView = self
        
        register(userInterface.dayTypes)
        register(userInterface.titleTypes)
        
        isPagingEnabled = true
        dataSource = model
        delegate = model
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func scrollToPreviousPage(animated: Bool) {
        if let page = model.previousPage {
            advance(to: page, animated: animated)
        }
    }
    
    public func scrollToNextPage(animated: Bool) {
        if let page = model.nextPage {
            advance(to: page, animated: animated)
        }
    }
    
    public func scrollToPage(displaying date: Date, animated: Bool) {
        if let page = model.page(for: date) {
            advance(to: page, animated: animated)
        }
    }
    
    private func advance(to page: Int, animated: Bool) {
        let x = model.pageWidth(self) * CGFloat(page)
        setContentOffset(CGPoint(x: x, y: 0), animated: animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.model.storeCurrentPage(self)
        }
    }
}
