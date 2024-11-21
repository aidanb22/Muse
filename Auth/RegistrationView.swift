//
//  RegistrationView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/18/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert = false
    @State private var isRegistered = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title
                HStack {
                    Text("Register")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                // Display Name
                TextField("Display Name", text: $displayName)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .autocapitalization(.words)
                
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
                
                // Register Button
                Button(action: registerUser) {
                    Text("Sign Up")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Registration Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }

                // NavigationLink (New API)
                NavigationLink(value: isRegistered) {
                    EmptyView()
                }
                HStack {
                    Text("Already a user?")
                    NavigationLink("Sign In", destination: LoginView())
                        .foregroundColor(.blue)
                }
            
            .padding()
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isRegistered) {
                ContentView()
            }
        }
    }

    private func registerUser() {
        guard !email.isEmpty, !password.isEmpty, !displayName.isEmpty else {
            errorMessage = "All fields are required."
            showAlert = true
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Auth Error: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
                showAlert = true
            } else if let user = result?.user {
                print("User registered with UID: \(user.uid)")
                saveUserToFirestore(uid: user.uid)
                isRegistered = true
            }
        }
    }




    private func saveUserToFirestore(uid: String) {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "uid": uid,
            "displayName": displayName,
            "email": email,
            "createdAt": Timestamp()
        ]

        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("Firestore Error: \(error.localizedDescription)")
                errorMessage = "Failed to save user: \(error.localizedDescription)"
                showAlert = true
            } else {
                print("User successfully saved to Firestore!")
            }
        }
    }
}

#Preview {
    RegistrationView()
}
