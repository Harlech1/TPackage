[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)

A boilerplate for swift.
It contains:
- Onboarding/Paywall View
- Settings View
- Documents View

## Usage

Here's a simple example for showing TKPaywallView:

```swift
import SwiftUI
import TPackage

struct ContentView: View {
    @State var showPaywall = false
    var body: some View {
        VStack {
            Button {
                showPaywall.toggle()
            } label: {
                Text("Show Paywall")
            }
        }
        .sheet(isPresented: $showPaywall) {
            TKPaywallView(headerImage: "crown.fill",
                          title: "Upgrade to Premium",
                          subtitle: "Try Now",
                          symbolColor: .purple,
                          features: [
                            .init(icon: "star.fill", title: "First Feature", description: "About First Feature"),
                            .init(icon: "star.fill", title: "Second Feature", description: "About Second Feature"),
                            .init(icon: "star.fill", title: "Third Feature", description: "About Third Feature")
                          ]
            )
        }
    }
}
```
