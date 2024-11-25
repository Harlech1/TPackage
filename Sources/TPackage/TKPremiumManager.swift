import Foundation
import RevenueCat

@available(iOS 15.0, macOS 10.15, *)
public class TKPremiumManager {
    public static let shared = TKPremiumManager()
    private var isConfigured = false
    
    private init() {}
    
    public func configure(apiKey: String) {
        guard !isConfigured else {
            print("TKPremiumManager is already configured")
            return
        }
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: apiKey)
        isConfigured = true
    }
} 