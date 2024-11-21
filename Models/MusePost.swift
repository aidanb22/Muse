//
//  MusePost.swift
//  Muse
//
//  Created by Aidan Blancas on 11/7/24.
//

import Foundation

struct MusePost: Identifiable, Codable {
    var id: String? // Firestore's document ID
    var uid: String // User ID
    var toName: String // name of dedication of post
    var songTitle: String
    var artist: String
    var highlightedLyric: String?
    var message: String
    var createdAt: Date
}


