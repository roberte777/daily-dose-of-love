//
//  SignUpOrSignInView.swift
//  Daily Dose of Love
//
//  Created by Ethan Wilkes on 10/27/24.
//


import SwiftUI

struct SignUpOrSignInView: View {
  @State private var isSignUp = true
  
  var body: some View {
    ScrollView {
      if isSignUp {
        SignUpView()
      } else {
        SignInView()
      }
      
      Button {
        isSignUp.toggle()
      } label: {
        if isSignUp {
          Text("Already have an account? Sign In")
        } else {
          Text("Don't have an account? Sign Up")
        }
      }
      .padding()
    }
  }
}
