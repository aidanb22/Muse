//
//  RootView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/20/24.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    @State private var isAuthenticated: Bool = Auth.auth().currentUser != nil
    @State private var listenerHandle: AuthStateDidChangeListenerHandle? // store the listener handle

    var body: some View {
        NavigationStack {
            if isAuthenticated {
                ContentView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            #if DEBUG
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                print("Preview mode detected. Mocking Firebase.")
                isAuthenticated = true // or false to test LoginView
            } else {
                monitorAuthState()
            }
            #else
            monitorAuthState()
            #endif
        }
        .onDisappear {
            if let handle = listenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }

    private func monitorAuthState() {
        listenerHandle = Auth.auth().addStateDidChangeListener { _, user in
            withAnimation {
                isAuthenticated = (user != nil)
            }
        }
    }
}

#Preview {
    RootView()
}
