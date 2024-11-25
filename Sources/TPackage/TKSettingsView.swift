import SwiftUI

@available(iOS 15.0, macOS 10.15, *)
public struct TKSettingsView: View {
    private var items: [SettingsItem]
    private let appId: String
    private let appName: String

    public struct SettingsItem {
        let icon: String
        let iconColor: Color
        let iconBackgroundColor: Color
        let title: String
        let action: () -> Void
        
        public init(
            icon: String,
            iconColor: Color,
            iconBackgroundColor: Color,
            title: String,
            action: @escaping () -> Void
        ) {
            self.icon = icon
            self.iconColor = iconColor
            self.iconBackgroundColor = iconBackgroundColor
            self.title = title
            self.action = action
        }
    }
    
    public init(
        appId: String,
        appName: String,
        items: [SettingsItem]
    ) {
        self.appId = appId
        self.appName = appName
        self.items = items
    }
    
    private static func openAppStoreForRating(appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)/?action=write-review") {
            UIApplication.shared.open(url)
        }
    }

    private static func sendEmail(to: String, subject: String, body: String) {
        let email = "mailto:\(to)?subject=\(subject)&body=\(body)"
        if let url = URL(string: email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }

    public static func shareApp(appUrl: String) {
        guard let url = URL(string: appUrl),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootVC = window.rootViewController else {
            print("Failed to share app: Invalid URL or window configuration")
            return
        }
        
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        
        rootVC.present(activityVC, animated: true)
    }

    public var body: some View {
        ForEach(items, id: \.title) { item in
            Label {
                Text(item.title)
                    .foregroundStyle(.primary)
            } icon: {
                Image(systemName: item.icon)
                    .foregroundStyle(item.iconColor)
                    .font(.system(size: 12))
                    .frame(width: 28, height: 28)
                    .background(item.iconBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .onTapGesture {
                item.action()
            }
        }
    }
}

#if DEBUG
@available(iOS 15.0, macOS 10.15, *)
struct TKSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TKSettingsView(
            appId: "123456789",
            appName: "My App",
            items: [
                .init(
                    icon: "person.circle.fill",
                    iconColor: .white,
                    iconBackgroundColor: .blue,
                    title: "Profile",
                    action: { print("Profile tapped") }
                ),
                .init(
                    icon: "key.fill",
                    iconColor: .white,
                    iconBackgroundColor: .green,
                    title: "Security",
                    action: { print("Security tapped") }
                )
            ]
        )
    }
}
#endif 
