//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Halle V` on 10/13/23.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}

struct AudioTrack: Codable {
    let album: Album
    let artists: [Artist]
    let available_markets: [String]
    let disc_number, duration_ms, popularity: Int
    let id, name: String
    let explicit: Bool
    let external_urls: [String: String]
}

