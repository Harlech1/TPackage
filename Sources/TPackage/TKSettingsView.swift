import SwiftUI

@available(iOS 15.0, macOS 10.15, *)
public struct TKSettingsView: View {
    private var title: String
    private var sections: [SettingsSection]
    
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
            iconColor: Color = .white,
            iconBackgroundColor: Color = .blue,
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
        title: String = "Settings",
        sections: [SettingsSection] = [
            .init(header: "Account", items: [
                .init(
                    icon: "airplane",
                    iconBackgroundColor: .orange,
                    title: "Airplane Mode",
                    action: { print("Profile tapped") }
                ),
                .init(
                    icon: "wifi",
                    iconBackgroundColor: .blue,
                    title: "Wi-Fi",
                    action: { print("Notifications tapped") }
                )
            ]),
            .init(header: "General", items: [
                .init(
                    icon: "gear",
                    iconBackgroundColor: .gray,
                    title: "Preferences",
                    action: { print("Preferences tapped") }
                ),
                .init(
                    icon: "info",
                    iconBackgroundColor: .blue,
                    title: "About",
                    action: { print("About tapped") }
                )
            ])
        ]
    ) {
        self.title = title
        self.sections = sections
    }
    
    public var body: some View {
        NavigationView {
            Form {
                ForEach(sections, id: \.header) { section in
                    Section(header: Text(section.header)) {
                        ForEach(section.items, id: \.title) { item in
                            Label {
                                Text(item.title)
                                    .foregroundStyle(.primary)
                            } icon: {
                                Image(systemName: item.icon)
                                    .foregroundStyle(item.iconColor)
                                    .font(.system(size: 14))
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
            .navigationTitle(title)
        }
    }
}

#if DEBUG
@available(iOS 15.0, macOS 10.15, *)
struct TKSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TKSettingsView()
        
        // Custom example
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
#endif 
