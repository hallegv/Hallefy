//
//  SettingsModels.swift
//  Spotify
//
//  Created by Halle V` on 10/13/23.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
