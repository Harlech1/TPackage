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
                Text("Test")
            }
        }.navigationTitle("Settings")
    }
}

#Preview {
    TestView()
}
