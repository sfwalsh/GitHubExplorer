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
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
