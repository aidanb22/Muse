//
//  CreateMuseView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/7/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore



struct CreateMuseView: View {
    @State private var songTitle: String = ""
    @State private var artist: String = ""
    @State private var highlightedLyric: String = ""
    @State private var message: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert = false
    
    @Environment(\.dismiss) var dismiss // Handles dismissing the view

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Create Your Muse")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    // Song Title Input
                    InputField(title: "Song Title", placeholder: "Enter song title", text: $songTitle)
                    
                    // Artist Name Input
                    InputField(title: "Artist Name", placeholder: "Enter artist name", text: $artist)
                    
                    // Highlighted Lyric Input
                    InputField(title: "Highlighted Lyric (optional)", placeholder: "Enter a lyric that resonates", text: $highlightedLyric)
                    
                    // Message Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Message")
                            .font(.headline)
                            .foregroundColor(.gray)
                        TextEditor(text: $message)
                            .padding()
                            .frame(height: 150)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    
                    // Submit Button
                    Button(action: submitMuse) {
                        Text("Submit Muse")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    .padding(.top, 20)
                    .alert("Submission Error", isPresented: $showAlert, actions: {
                        Button("OK", role: .cancel) {}
                    }, message: {
                        Text(errorMessage)
                    })
                }
                .padding()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle("Create Muse")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss the view
                    }
                }
            }
        }
    }

    private func submitMuse() {
        #if DEBUG
        print("Submitting Muse in preview mode.")
        dismiss()
        #else
        // Validation
        guard !songTitle.isEmpty, !artist.isEmpty, !message.isEmpty else {
            errorMessage = "All fields except the lyric are required."
            showAlert = true
            return
        }

        // Get the current user's UID
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "You must be logged in to create a Muse."
            showAlert = true
            return
        }

        // Create Muse object with explicit types
        let newMuse: [String: Any] = [
            "uid": uid,
            "toName": "Recipient Name", // Replace with actual value
            "songTitle": songTitle,
            "artist": artist,
            "highlightedLyric": highlightedLyric.isEmpty ? "" : highlightedLyric,
            "message": message,
            "createdAt": Timestamp()
        ]

        // Save to Firestore
        let db = Firestore.firestore()
        db.collection("posts").addDocument(data: newMuse) { error in
            if let error = error {
                errorMessage = "Failed to save Muse: \(error.localizedDescription)"
                showAlert = true
            } else {
                print("Muse successfully saved!")
                dismiss() // Dismiss the view on success
            }
        }
        #endif
    }
}

struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
        }
    }
}

#Preview {
    CreateMuseView()
}
