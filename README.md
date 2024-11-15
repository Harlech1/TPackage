[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)

## About

A boilerplate for swift.
It contains:
- Onboarding/Paywall View
- Settings View
- Documents View

## Usage

Here's a simple example for using TKPaywallView:

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
Here's a simple example for using TKSettingsView:

```swift
import SwiftUI
import TPackage

struct ContentView: View {
    var body: some View {
        TKSettingsView(
            title: "Settings",
            sections: [
                .init(header: "Account", items: [
                    .init(
                        icon: "person.circle.fill",
                        iconBackgroundColor: .blue,
                        title: "Profile",
                        action: { print("Profile tapped") }
                    ),
                    .init(
                        icon: "key.fill",
                        iconBackgroundColor: .green,
                        title: "Security",
                        action: { print("Security tapped") }
                    ),
                    .init(
                        icon: "bell.fill",
                        iconBackgroundColor: .orange,
                        title: "Notifications",
                        action: { print("Notifications tapped") }
                    )
                ])
            ]
        )
    }
}
```



