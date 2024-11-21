//
//  LoginView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/18/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isAuthenticated = false
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title
                HStack {
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                
                
                // Email
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                // Password
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
//                 Login Button
                Button(action: loginUser) {
                    Text("Log In")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                
                // NavigationLink
                NavigationLink(value: isAuthenticated) {
                    EmptyView()
                }
                HStack {
                    Text("Don't have an account?")
                    NavigationLink("Register here", destination: RegistrationView())
                        .foregroundColor(.blue)
                }
            
            .padding()
                
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isAuthenticated) {
                ContentView()
            }
        }
    }
    private func loginUser(){
        guard !email.isEmpty, !password.isEmpty else{
            errorMessage = "Please enter both email and password"
            showAlert = true
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                errorMessage = "Invalid credentials. Please try again"
                showAlert = true
            } else {
                isAuthenticated = true
            }
        }
    }

}

#Preview {
    LoginView()
}
