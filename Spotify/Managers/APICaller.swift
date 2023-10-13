//
//  APICaller.swift
//  Spotify
//
//  Created by Halle V` on 9/7/23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        AuthManager.shared.withValidToken { token in
             
        }
    }
}
