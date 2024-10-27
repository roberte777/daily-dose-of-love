//
//  SignUpView.swift
//  Daily Dose of Love
//
//  Created by Ethan Wilkes on 10/27/24.
//

import SwiftUI
import ClerkSDK

struct SignUpView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var code = ""
  @State private var isVerifying = false
  @State private var errorMessage: String? // Error message state variable
  
  var body: some View {
    VStack {
      Text("Sign Up")
        
      if let errorMessage = errorMessage {
        Text(errorMessage) // Display error message
          .foregroundColor(.red)
          .multilineTextAlignment(.center)
          .padding()
      }
        
      if isVerifying {
        TextField("Code", text: $code)
        Button("Verify") {
          Task { await verify(code: code) }
        }
      } else {
        TextField("Email", text: $email)
        SecureField("Password", text: $password)
        Button("Continue") {
          Task { await signUp(email: email, password: password) }
        }
      }
    }
    .padding()
  }
}

extension SignUpView {
  
  func signUp(email: String, password: String) async {
    do {
      let signUp = try await SignUp.create(
        strategy: .standard(emailAddress: email, password: password)
      )
      
      try await signUp.prepareVerification(strategy: .emailCode)

      isVerifying = true
      errorMessage = nil // Clear any previous errors
    } catch {
        if let clerkError = error as? ClerkAPIError, let message = clerkError.message {
          errorMessage = message // Use error message from ClerkError if available
        } else {
          errorMessage = "Failed to sign up. Please check your details and try again." // Set default error message
        }
        dump(error)
    }
  }
  
  func verify(code: String) async {
    do {
      guard let signUp = Clerk.shared.client?.signUp else {
        errorMessage = "Unexpected error. Please try again." // Set error message
        isVerifying = false
        return
      }
      
      try await signUp.attemptVerification(.emailCode(code: code))
      errorMessage = nil // Clear any previous errors
    } catch {
      errorMessage = "Verification failed. Please check the code and try again." // Set error message
      dump(error)
    }
  }
}

#Preview {
    SignUpView()
}
