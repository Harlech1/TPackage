import Foundation
import SwiftUI
import RevenueCat

@available(iOS 15.0, macOS 10.15, *)
public class TKPremiumManager: ObservableObject {
    public static let shared = TKPremiumManager()
    private var isConfigured = false
    var entitlementIdentifier: String
    
    @Published public var isPremium: Bool = false
    
    public init() {
        self.entitlementIdentifier = ""
    }
    
    public func configure(apiKey: String, entitlementIdentifier: String) {
        guard !isConfigured else {
            print("TKPremiumManager is already configured")
            return
        }
        
        self.entitlementIdentifier = entitlementIdentifier
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: apiKey)
        isConfigured = true
        
        Task {
            await checkPremiumStatus()
        }
    }
    
    func isEntitlementActive(_ customerInfo: CustomerInfo) -> Bool {
        customerInfo.entitlements[entitlementIdentifier]?.isActive == true
    }
    
    @MainActor
    public func checkPremiumStatus() async {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            self.isPremium = isEntitlementActive(customerInfo)
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
            self.isPremium = isEntitlementActive(customerInfo)
            return self.isPremium
        } catch {
            print("Error restoring purchases: \(error)")
            self.isPremium = false
            return false
        }
    }
} 
