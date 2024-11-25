import SwiftUI

@available(iOS 15.0, macOS 10.15, *)
public struct TKSettingsView: View {
    private var sections: [SettingsSection]
    private let appId: String
    private let appName: String
    private let appUrl: String

    public struct SettingsSection {
        let header: String
        let items: [SettingsItem]
        
        public init(
            header: String,
            items: [SettingsItem]
        ) {
            self.header = header
            self.items = items
        }
    }
    
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
        appUrl: String,
        sections: [SettingsSection]
    ) {
        self.appId = appId
        self.appName = appName
        self.appUrl = appUrl
        self.sections = sections
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

    private static func shareApp(appUrl: String) {
        let url = URL(string: appUrl)!
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }

    public var body: some View {
        ForEach(sections, id: \.header) { section in
            Section(header: Text(section.header)) {
                ForEach(section.items, id: \.title) { item in
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
    }
}

#if DEBUG
@available(iOS 15.0, macOS 10.15, *)
struct TKSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TKSettingsView(
            appId: "123456789",
            appName: "My App",
            appUrl: "https://apps.apple.com/app/123456789",
            sections: [
                .init(header: "Account", items: [
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
                ])
            ]
        )
    }
}
#endif 
