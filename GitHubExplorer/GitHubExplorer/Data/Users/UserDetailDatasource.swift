//
//  UserDetailDatasource.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

protocol UserDataSource {
    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error>
}

struct RemoteUserDataSource: UserDataSource {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error> {
        guard let url = URL(string: "https://api.github.com/users/\(userId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return apiClient.fetchData(with: request)
    }
}
