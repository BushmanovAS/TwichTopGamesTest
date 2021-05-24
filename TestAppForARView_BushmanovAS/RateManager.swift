import UIKit
import StoreKit

class RateManager {
    
    static func showRateConroller() {
        SKStoreReviewController.requestReview()
    }
    
}
