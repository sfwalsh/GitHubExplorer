//
//  GetUserRepos.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

struct GetUserRepos: UseCase {
    // GET /users/*/repos
    typealias T = RequestValues
    typealias U = [RepoDTO]
    
    private let repository: UserRepoRepository
    
    init(repository: UserRepoRepository) {
        self.repository = repository
    }
    
    func invoke(requestValues: RequestValues) -> AnyPublisher<[RepoDTO], Error> {
        repository.fetchRepoList(for: requestValues.username)
    }
}


extension GetUserRepos {
    struct RequestValues {
        let username: String
    }
}
