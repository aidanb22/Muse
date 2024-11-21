//
//  MuseCardView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/7/24.
//

import SwiftUI

struct MuseCardView: View {
    var toName: String
    var songTitle: String
    var artist: String
    var highlightedLyric: String?
    var message: String
    var colorIndex: Int
    
    private let gradientColors: [[Color]] = [
            [.white, Color.blue.opacity(0.2)],
            [.white, Color.green.opacity(0.2)],
            [.white, Color.purple.opacity(0.2)],
            [.white, Color.orange.opacity(0.2)],
            [.white, Color.pink.opacity(0.2)]
        ]
    
    var body: some View {
                HStack {
                   VStack(alignment: .leading, spacing: 8) {
                       HStack{
                           Text("To:")
                               .font(.subheadline)
                               .fontWeight(.bold)
                               .foregroundColor(.black)
                           Text(toName)
                               .font(.subheadline)
                               .italic()
                               .foregroundColor(.black) // Customize the color here
                       }
                       
                                       
                       
                       
                       Text(songTitle)
                           .font(.headline)
                           .foregroundColor(.black)
                       
                       Text("by \(artist)")
                           .font(.subheadline)
                           .foregroundColor(.black.opacity(0.7))
                       
                       if let lyric = highlightedLyric {
                           Text("“\(lyric)”")
                               .italic()
                               .foregroundColor(.black)
                               .padding(.top, 4)
                       }
                       
                       Text(message)
                           .font(.body)
                           .foregroundColor(.black)
                           .padding(.top, 8)
                   }
                   
                   Spacer()

                   // Placeholder for the cover art
                   Image(systemName: "music.note")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 60, height: 60)
                       .background(Color.gray.opacity(0.2))
                       .cornerRadius(10)
                       .padding(.leading, 10)
               }
               .padding()
               .background(
                   LinearGradient(
                       gradient: Gradient(colors: gradientColors[colorIndex % gradientColors.count]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
                   )
               )
               .cornerRadius(15)
               .shadow(radius: 5)
               .padding(.horizontal)
    }
}

#Preview {
    MuseCardView(toName: "Aidan", songTitle: "Cologne", artist: "beabadoobee", message: "this song reminds me of you!", colorIndex: 5)
}
