//
//  UserDetailDatasource.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

protocol UserDataSource {
    func fetchUsers(since: Int?) -> AnyPublisher<[UserDTO], Error>
    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error>
}

struct RemoteUserDataSource: UserDataSource {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchUsers(since: Int?) -> AnyPublisher<[UserDTO], Error> {
        guard var components = URLComponents(string: "https://api.github.com/users") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        if let since = since {
            components.queryItems = [URLQueryItem(name: "since", value: "\(since)")]
        }
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return apiClient.fetchData(with: request)
    }
    
    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error> {
        guard let url = URL(string: "https://api.github.com/users/\(userId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return apiClient.fetchData(with: request)
    }
}
