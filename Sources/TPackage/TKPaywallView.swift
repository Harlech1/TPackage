import SwiftUI
import RevenueCat
import RevenueCatUI

@available(iOS 15.0, macOS 10.15, *)
public struct TKPaywallView: View {
    private var headerImage: String
    private var title: String
    private var subtitle: String
    private var symbolColor: Color
    private var features: [FeatureItem]
    private var displayCloseButton: Bool
    @Environment(\.dismiss) private var dismiss

    public struct FeatureItem {
        let icon: String
        let title: String
        let description: String
        
        public init(
            icon: String,
            title: String,
            description: String
        ) {
            self.icon = icon
            self.title = title
            self.description = description
        }
    }
    
    public init(
        headerImage: String = "star.fill",
        title: String = "Your Feature Title Here",
        subtitle: String = "Add your subtitle text here. Describe your main features or value proposition.",
        symbolColor: Color = .blue,
        displayCloseButton: Bool = true,
        features: [FeatureItem] = [
            .init(
                icon: "star.fill",
                title: "Feature One",
                description: "Describe your first feature here."
            ),
            .init(
                icon: "heart.fill",
                title: "Feature Two",
                description: "Describe your second feature."
            ),
            .init(
                icon: "bolt.fill",
                title: "Feature Three",
                description: "Describe your third feature."
            ),
            .init(
                icon: "sparkles",
                title: "Feature Four",
                description: "Describe your fourth feature."
            )
        ]
    ) {
        self.headerImage = headerImage
        self.title = title
        self.subtitle = subtitle
        self.symbolColor = symbolColor
        self.features = features
        self.displayCloseButton = displayCloseButton
    }
    
    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    symbolColor.opacity(0.2),
                    .clear
                ],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if displayCloseButton {
                        HStack {
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title2)
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(symbolColor)
                                    .padding()
                            }
                        }
                    }
                    
                    Image(systemName: headerImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(symbolColor)
                        .frame(width: 64, height: 64, alignment: .center)
                        .padding(.top, displayCloseButton ? 0 : 32)

                    Text(title)
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)
                    
                    Text(subtitle)
                        .foregroundStyle(.gray)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    
                    ForEach(features, id: \.title) { feature in
                        FeatureRow(feature: feature, symbolColor: symbolColor)
                            .padding(.horizontal, 24)
                            .padding(.top, 24)
                    }
                }
            }.padding(.horizontal, 16)
        }
        .paywallFooter()
        .onPurchaseCompleted { customerInfo in
            if customerInfo.entitlements[TKPremiumManager.shared.entitlementIdentifier]?.isActive == true {
                dismiss()
            }
            Task {
                await TKPremiumManager.shared.checkPremiumStatus()
            }
        }
        .onRestoreCompleted { customerInfo in
            if customerInfo.entitlements[TKPremiumManager.shared.entitlementIdentifier]?.isActive == true {
                dismiss()
            }
            Task {
                await TKPremiumManager.shared.checkPremiumStatus()
            }
        }
    }
}

@available(iOS 15.0, macOS 10.15, *)
private struct FeatureRow: View {
    let feature: TKPaywallView.FeatureItem
    let symbolColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Image(systemName: feature.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 8)
                    .foregroundStyle(symbolColor)
            }
            
            VStack {
                Text(feature.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(feature.description)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#if DEBUG
@available(iOS 15.0, macOS 10.15, *)
struct TKPaywallView_Previews: PreviewProvider {
    static var previews: some View {
        TKPaywallView(
            headerImage: "crown.fill",
            title: "Upgrade to Premium",
            subtitle: "Get unlimited access to all features",
            symbolColor: .purple,
            displayCloseButton: true,
            features: [
                .init(
                    icon: "infinity",
                    title: "Unlimited Access",
                    description: "Unlimited access to all premium content"
                ),
                .init(
                    icon: "bell.fill",
                    title: "Notifications",
                    description: "Stay informed with special notifications"
                )
            ]
        )
    }
}
#endif


