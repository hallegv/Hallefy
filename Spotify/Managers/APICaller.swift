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
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"),
                      type: .GET,
                      completion: { baseReq in
            let task = URLSession.shared.dataTask(with: baseReq) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let res = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(res)
                    completion(.success(res))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        })
    }
    
    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { req in
            let task = URLSession.shared.dataTask(with: req) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let res = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    print(res)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists"), type: .GET) { req in
            let task = URLSession.shared.dataTask(with: req) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let res = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    print(res)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
            
        }
    }
    
    public func getRecommendedGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { req in
            let task = URLSession.shared.dataTask(with: req) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let res = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    print(res)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
            
        }
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping (Result<RecommendationsResponse, Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { req in
            let task = URLSession.shared.dataTask(with: req) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let res = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(res))
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()

        }
    }
    
    enum HTTPMethod: String {
        case GET, POST
    }
    
    // MARK: - Private
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let url = url else { return }
            
            var req = URLRequest(url: url)
            req.setValue("Bearer \(token)",
                         forHTTPHeaderField: "Authorization")
            req.httpMethod = type.rawValue
            req.timeoutInterval = 30
            
            completion(req)
        }
    }
}
