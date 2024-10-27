//
//  ContentView.swift
//  Daily Dose of Love
//
//  Created by Ethan Wilkes on 10/27/24.
//

import SwiftUI
import ClerkSDK

struct ContentView: View {
    @ObservedObject private var clerk = Clerk.shared

    var body: some View {
        VStack {
           if let user = clerk.user {
             Text("Hello, \(user.id)")
           } else {
               SignUpOrSignInView()
           }
         }
    }
}

#Preview {
    ContentView()
}
