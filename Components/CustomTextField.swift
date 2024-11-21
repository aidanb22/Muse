//
//  CustomTextField.swift
//  Muse
//
//  Created by Aidan Blancas on 11/18/24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .padding(10)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
}

struct PreviewWrapper: View {
    @State private var text: String = "" // Use @State to create a binding

    var body: some View {
        CustomTextField(placeholder: "Enter text", text: $text) // Pass the binding using $
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
