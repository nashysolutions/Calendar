import Foundation

struct Utility {
    
    static func errorContainsSuitableInformation(_ error: Error) -> Bool {
        guard let error = error as? LocalizedError else {
            return false
        }
        guard error.errorDescription != nil else {
            return false
        }
        guard error.failureReason != nil else {
            return false
        }
        guard error.recoverySuggestion != nil else {
            return false
        }
        return true
    }
}
