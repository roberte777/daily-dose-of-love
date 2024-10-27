//
//  SignInView.swift
//  Daily Dose of Love
//
//  Created by Ethan Wilkes on 10/27/24.
//


import SwiftUI
import ClerkSDK

struct SignInView: View {
  @State private var email = ""
  @State private var password = ""
  
  var body: some View {
    VStack {
      Text("Sign In")
      TextField("Email", text: $email)
      SecureField("Password", text: $password)
      Button("Continue") {
        Task { await submit(email: email, password: password) }
      }
    }
    .padding()
  }
}

extension SignInView {
    
  func submit(email: String, password: String) async {
    do {
      try await SignIn.create(
        strategy: .identifier(email, password: password)
      )
    } catch {
      dump(error)
    }
  }
    
}
