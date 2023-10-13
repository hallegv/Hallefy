//
//  UserProfile.swift
//  Spotify
//
//  Created by Halle V` on 9/7/23.
//

import Foundation

struct UserImage: Codable {
    let url: String
}

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let images: [UserImage]
    let product: String
}
