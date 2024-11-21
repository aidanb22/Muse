//
//  ProfileView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/7/24.
//
import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var showLogin = false // State to redirect to LoginView after logout
    @State private var userName: String = "" // Holds the user's display name
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Greeting with User's Name
                Text("Hello, \(userName.isEmpty ? "User" : userName)!")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Spacer to push Logout button to the bottom
                Spacer()
                
                // Logout Button
                Button(action: logoutUser) {
                    Text("Log Out")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .padding()
            .onAppear {
                fetchUserName()
            }
            .navigationDestination(isPresented: $showLogin) {
                LoginView() // Redirect to LoginView after logout
            }
        }
    }
    
    // Fetch the logged-in user's name
    private func fetchUserName() {
        if let user = Auth.auth().currentUser {
            userName = user.displayName ?? "User"
        } else {
            userName = "Guest"
        }
    }
    
    // Logout Functionality
    private func logoutUser() {
        do {
            try Auth.auth().signOut()
            showLogin = true // Navigate to LoginView after successful logout
        } catch let error {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProfileView()
}
