//
//  UserRepoDatasource.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

protocol UserRepoDatasource {
    func fetchRepoList(for userId: String) -> AnyPublisher<[RepoDTO], Error>
}

struct RemoteUserRepoDatasource: UserRepoDatasource {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchRepoList(for userId: String) -> AnyPublisher<[RepoDTO], Error> {
        guard let url = URL(string: "https://api.github.com/users/\(userId)/repos") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return apiClient.fetchData(with: request)
    }
}

