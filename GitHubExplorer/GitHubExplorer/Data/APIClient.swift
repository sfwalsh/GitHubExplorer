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
    
    private enum Headers: String {
        case auth = "Authorization"
        case userAgent = "User-Agent"
        case accept = "Accept"
        case apiVersion = "X-GitHub-Api-Version"
    }
    
    func fetchData<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, Error> {
        
        guard let githubToken = ProcessInfo.processInfo.environment["GITHUB_TOKEN"] else {
            // NOTE: fatalError is used only here for the coding challenge purposes. It would never be used in a real environment.
            fatalError("Please set your personal access token in the scheme's environment variables under the key `GITHUB_TOKEN`")
        }
        
        var authenticatedRequest = request
        authenticatedRequest.addValue("Bearer \(githubToken)", forHTTPHeaderField: Headers.auth.rawValue)
        authenticatedRequest.addValue("GitHubExplorer", forHTTPHeaderField: Headers.userAgent.rawValue)
        authenticatedRequest.addValue("application/vnd.github+json", forHTTPHeaderField: Headers.accept.rawValue)
        authenticatedRequest.addValue("2022-11-28", forHTTPHeaderField: Headers.apiVersion.rawValue)

        return URLSession.shared.dataTaskPublisher(for: authenticatedRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
