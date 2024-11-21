//
//  ContentView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
               ForYouPageView()
                   .tabItem {
                       Image(systemName: "heart.fill")
                       Text("For You")
                   }
               
               ExploreView()
                   .tabItem {
                       Image(systemName: "magnifyingglass")
                       Text("Explore")
                   }
        
                CreateMuseView()
                                .tabItem {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 30))
                                    Text("Create")
                                }
               
               MessagesView()
                   .tabItem {
                       Image(systemName: "message.fill")
                       Text("Messages")
                   }
               
               ProfileView()
                   .tabItem {
                       Image(systemName: "person.fill")
                       Text("Profile")
                   }
           }
            .navigationBarBackButtonHidden(true)
           .accentColor(.blue) // Customize tab selection color
    }
}

#Preview {
    ContentView()
}
