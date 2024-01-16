//
//  APIClient.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

protocol APIClient {
    func fetchData<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, Error>
}

struct DefaultAPIClient: APIClient {
    func fetchData<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, Error> {
        
        guard let githubToken = ProcessInfo.processInfo.environment["GITHUB_TOKEN"] else {
            // NOTE: fatalError is used only here for the coding challenge purposes. It would never be used in a real environment.
            fatalError("Please set your personal access token in the scheme's environment variables under the key `GITHUB_TOKEN`")
        }
        
        var authenticatedRequest = request
        authenticatedRequest.addValue("Bearer \(githubToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
