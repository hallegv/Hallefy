//
//  FeaturedPlaylistsResponse.swift
//  Spotify
//
//  Created by Halle V` on 10/13/23.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: PlaylistUser
}

struct PlaylistUser: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
