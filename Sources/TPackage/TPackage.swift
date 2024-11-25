import Foundation
import RevenueCat

@available(iOS 15.0, macOS 10.15, *)
public enum TPackage {
    public static func configure(withAPIKey apiKey: String) {
        TKPremiumManager.shared.configure(apiKey: apiKey)
    }
} 