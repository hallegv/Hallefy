//
//  Artist.swift
//  Spotify
//
//  Created by Halle V` on 9/7/23.
//

import Foundation

struct Artist: Codable {
    let id, name, type: String
    let external_urls: [String: String]
}
