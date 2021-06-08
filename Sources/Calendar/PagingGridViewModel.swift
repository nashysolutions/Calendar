import UIKit

final class PagingGridViewModel: NSObject, MonthDataSource {
    
    let startDate: Date
    let endDate: Date
    private let calendar: Calendar
    
    var currentSelection: Day?
    
    private weak var currentMonthTitleView: TitleUserInterface?
    
    weak var collectionView: UICollectionView?
    
    private var currentPage: Int = 0
    
    private func updateTitleView() {
        let month = month(at: currentPage)
        let title = month.title
        currentMonthTitleView?.update(with: title)
    }
    
    func storeCurrentPage(_ scrollView: UIScrollView) {
        currentPage = establishCurrentPage(scrollView)
        updateTitleView()
    }
    
    func page(for date: Date) -> Int? {
        guard startDate.compare(date) == .orderedAscending || date.compare(endDate) == .orderedAscending else {
            return nil
        }
        if let page = calendar.dateComponents([.month], from: startDate.startOfMonth(), to: date.startOfMonth()).month, page < totalMonths {
            return page
        }
        return nil
    }
    
    private var longestMonth: Month!
    
    init(dates: Dates, calendar: Calendar) {
        self.startDate = dates.startDate
        self.endDate = dates.endDate
        self.calendar = calendar
        super.init()
        establishLongestMonth()
    }
    
    private func establishLongestMonth() {
        longestMonth = Month(date: startDate, dataSource: self, calendar: calendar)
        var longest = calendar.range(of: .day, in: .month, for: startDate)!.count
        var index = 1
        while longest < 31 {
            if let date = calendar.date(byAdding: DateComponents(month: index), to: startDate), date.compare(endDate) == .orderedAscending {
                longest = calendar.range(of: .day, in: .month, for: date)!.count
                longestMonth = Month(date: date, dataSource: self, calendar: calendar)
            } else {
                break
            }
            index += 1
        }
    }
    
    var canPageToPrevious: Bool {
        let page = currentPage - 1
        return page >= 0
    }
    
    var previousPage: Int? {
        guard canPageToPrevious else {
            return nil
        }
        return currentPage - 1
    }
    
    var canPageToNext: Bool {
        let page = currentPage + 1
        return page < totalMonths
    }
    
    var nextPage: Int? {
        guard canPageToNext else {
            return nil
        }
        return currentPage + 1
    }
        
    private func dayIsSelectable(day: Day) -> Bool {
        if let selection = day.membership.selection {
            if case .withinRange = selection {
                return true
            }
        }
        return false
    }
    
    var totalMonths: Int {
        let from = startDate.startOfMonth()
        let to = endDate.startOfMonth()
        let components = calendar.dateComponents([.month], from: from, to: to)
        return components.month! + 1
    }
    
    func month(at index: Int) -> Month {
        if index == 0 {
            return Month(date: startDate, dataSource: self, calendar: calendar)
        }
        let date = calendar.date(byAdding: DateComponents(month: index), to: startDate)!
        return Month(date: date, dataSource: self, calendar: calendar)
    }
    
    private func establishCurrentPage(_ scrollView: UIScrollView) -> Int {
        let pw = pageWidth(scrollView)
        let a = scrollView.contentOffset.x
        let b = scrollView.contentInset.left
        let c = (a - b)
        let d = c - pw / 2.0
        let e = d / pw
        return Int(floor(e)) + 1
    }
    
    func pageWidth(_ scrollView: UIScrollView) -> CGFloat {
        let width = scrollView.frame.size.width
        let left: CGFloat = scrollView.contentInset.left
        let right: CGFloat = scrollView.contentInset.right
        return width - (left + right)
    }
}

extension PagingGridViewModel: PagingGridViewLayoutDataSource {
    
    func pagingGridViewLayoutLongestMonth(_ layout: PagingGridViewLayout) -> Month {
        longestMonth
    }
}

extension PagingGridViewModel: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        totalMonths
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let month = month(at: section)
        return month.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let month = month(at: indexPath.section)
        let day = month.days[indexPath.item]
        let position = DayPosition.position(for: day)
        let identifier = position.identifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? DayUserInterface else {
            fatalError()
        }
        cell.update(with: day, calendar: calendar)
        return cell as UICollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected reusable view")
        }
        if indexPath.item == 0 {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitlePosition.month.identifier, for: indexPath) as? TitleUserInterface else {
                fatalError("Unexpected reusable view")
            }
            let month = month(at: indexPath.section)
            view.update(with: month.title)
            currentMonthTitleView = view
            return view as UICollectionReusableView
        }
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitlePosition.day.identifier, for: indexPath) as? TitleUserInterface else {
            fatalError("Unexpected reusable view")
        }
        let name = Day.Name(index: indexPath.item)?.shortName ?? ""
        view.update(with: name)
        return view as UICollectionReusableView
    }
}

extension PagingGridViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let month = month(at: indexPath.section)
        let day = month.days[indexPath.item]
        if dayIsSelectable(day: day) == true {
            currentSelection = day
            if case .previous = day.membership {
                didSelectSpacerDay(day, at: indexPath, in: collectionView)
            } else if case .next = day.membership {
                didSelectSpacerDay(day, at: indexPath, in: collectionView)
            }
        } else {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
    private func didSelectSpacerDay(_ day: Day, at indexPath: IndexPath, in collectionView: UICollectionView) {
        let shift: Int
        if case .previous = day.membership {
            shift = -1
        } else {
            shift = 1
        }
        let section = indexPath.section + shift
        let month = month(at: section)
        guard let d = month.days.first(where: { $0 == day }), let item = month.days.firstIndex(of: d) else {
            return
        }
        let indexPath = IndexPath(item: item, section: section)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            let x = self.pageWidth(collectionView) * CGFloat(indexPath.section)
            let top: CGFloat = collectionView.contentInset.top
            collectionView.setContentOffset(CGPoint(x: x, y: -top), animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition())
                self.currentPage = self.establishCurrentPage(collectionView)
                self.updateTitleView()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentPage = establishCurrentPage(scrollView)
        updateTitleView()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            currentPage = establishCurrentPage(scrollView)
            updateTitleView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = establishCurrentPage(scrollView)
        updateTitleView()
    }
}
