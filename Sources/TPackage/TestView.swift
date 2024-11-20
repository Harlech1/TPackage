//
//  SwiftUIView.swift
//  TPackage
//
//  Created by Türker Kızılcık on 20.11.2024.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationView {
            Form {
                TKSettingsView(appId: "6737987351", appName: "Concrete Calculator", appUrl: "https://apps.apple.com/us/app/concrete-calculator/id6737987351")
            }
        }.navigationTitle("Settings")
    }
}

#Preview {
    TestView()
}
