import Foundation
import SwiftUI
import RevenueCat

@available(iOS 15.0, macOS 10.15, *)
public class TKPremiumManager: ObservableObject {
    public static let shared = TKPremiumManager()
    private var isConfigured = false
    var entitlementIdentifier: String = "Pro"
    
    @Published public var isPremium: Bool = false
    
    public init() {
        Task {
            await checkPremiumStatus()
        }
    }
    
    public func configure(apiKey: String, entitlementIdentifier: String = "Pro") {
        guard !isConfigured else {
            print("TKPremiumManager is already configured")
            return
        }
        
        self.entitlementIdentifier = entitlementIdentifier
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: apiKey)
        isConfigured = true
    }
    
    @MainActor
    public func checkPremiumStatus() async {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            self.isPremium = customerInfo.entitlements[entitlementIdentifier]?.isActive == true
            print("Premium Status: \(self.isPremium)")
        } catch {
            print("Failed to fetch customer info: \(error.localizedDescription)")
            self.isPremium = false
        }
    }
    
    @MainActor
    public func restorePurchases() async -> Bool {
        do {
            let customerInfo = try await Purchases.shared.restorePurchases()
            self.isPremium = customerInfo.entitlements[entitlementIdentifier]?.isActive == true
            return self.isPremium
        } catch {
            print("Error restoring purchases: \(error)")
            self.isPremium = false
            return false
        }
    }
} 
