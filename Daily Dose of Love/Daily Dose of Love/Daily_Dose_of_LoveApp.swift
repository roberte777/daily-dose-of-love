//
//  Daily_Dose_of_LoveApp.swift
//  Daily Dose of Love
//
//  Created by Ethan Wilkes on 10/27/24.
//

import SwiftUI
import ClerkSDK

@main
struct Daily_Dose_of_LoveApp: App {
    @ObservedObject private var clerk = Clerk.shared

    var body: some Scene {
        WindowGroup {
            ZStack {
               if clerk.loadingState == .notLoaded {
                 ProgressView()
               } else {
                 ContentView()
               }
             }
             .task {
               clerk.configure(publishableKey: "pk_test_Y29udGVudC1wZWFjb2NrLTYuY2xlcmsuYWNjb3VudHMuZGV2JA")
               try? await clerk.load()
             }
        }
    }
}
