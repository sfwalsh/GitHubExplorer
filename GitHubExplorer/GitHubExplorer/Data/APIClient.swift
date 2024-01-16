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
        let primedRequest = primeRequest(for: request)
        return URLSession.shared.dataTaskPublisher(for: primedRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func primeRequest(for request: URLRequest) -> URLRequest {
        guard let githubToken = ProcessInfo.processInfo.environment["GITHUB_TOKEN"] else {
            print("Please set your personal access token in the scheme's environment variables under the key `GITHUB_TOKEN`")
            return request
        }
        
        var authenticatedRequest = request
        authenticatedRequest.addValue("Bearer \(githubToken)", forHTTPHeaderField: Headers.auth.rawValue)
        authenticatedRequest.addValue("GitHubExplorer", forHTTPHeaderField: Headers.userAgent.rawValue)
        authenticatedRequest.addValue("application/vnd.github+json", forHTTPHeaderField: Headers.accept.rawValue)
        authenticatedRequest.addValue("2022-11-28", forHTTPHeaderField: Headers.apiVersion.rawValue)
        return authenticatedRequest
    }
}
