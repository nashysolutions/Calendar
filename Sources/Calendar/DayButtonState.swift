import Foundation

/// The behaviour of a day within a grid of days for a displayed month.
public enum DayButtonState: String, CaseIterable {
    
    /// Is within range of month and within range of the users specified date range.
    case normal
    
    /// A leading day from the previous month that is still within range of the users specified date range.
    case spacer
    
    /// Is within range of the month being displayed but is not within range of the users specified date range
    case disabled
    
    // Is not within range of the month being displayed and is not within range of the users specified date range
    case invisible
}
