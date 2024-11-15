[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)

## About

A boilerplate for swift.
It contains:
- Onboarding/Paywall View
- Settings View
- Documents View

## Installation

### Swift Package Manager

You can install PKSNavigation using the [Swift Package Manager](https://swift.org/package-manager/):

1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency...
2. Paste the repository URL: https://github.com/Harlech1/TPackage.git
3. Click Next and select the version you want to use

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

| Main View                                                   | Detail View                                                        |
| ----------------------------------------------------------- | ------------------------------------------------------------------ |
| <img src="https://github.com/user-attachments/assets/d8215e74-3c64-41e4-92ea-0f60ce9f501f" width="300"/>
 | <img src="https://github.com/user-attachments/assets/e0af2c70-6eeb-4328-8194-e96aa20ffde6" width="300"/> |

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
![IMG_3285](https://github.com/user-attachments/assets/e0af2c70-6eeb-4328-8194-e96aa20ffde6)
![IMG_3284](https://github.com/user-attachments/assets/d8215e74-3c64-41e4-92ea-0f60ce9f501f)


<img src="https://github.com/user-attachments/assets/78cb4139-fc5e-44ff-91f2-85a5e5979a99" width="300"/>




