//
//  ForYouPageView.swift
//  Muse
//
//  Created by Aidan Blancas on 11/7/24.
//

import SwiftUI

struct ForYouPageView: View {
    var body: some View {
        ScrollView {
                    VStack(spacing: 16) {
                        ForEach(0..<10) { _ in
                            MuseCardView(
                                toName: "Aidan", songTitle: "Dreams",
                                artist: "Fleetwood Mac",
                                highlightedLyric: "“You can go your own way”",
                                message: "This song helped me through a tough time and gave me courage.", colorIndex: 5
                            )
                        }
                    }
                    .padding(.top)
                }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    ForYouPageView()
}
