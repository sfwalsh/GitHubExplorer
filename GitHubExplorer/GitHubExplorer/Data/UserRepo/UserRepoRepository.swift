//
//  UserRepoRepository.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

/*
 This is a difficult stack to name, with the overlapping term "repository";
 so I have opted to use "Repo" to refer to Git Repositories
*/

protocol UserRepoRepository {
    func fetchRepoList(for userId: String) -> AnyPublisher<[RepoDTO], Error>
}

struct DefaultUserRepoRepository: UserRepoRepository {
    private let datasource: UserRepoDatasource
    
    init(datasource: UserRepoDatasource) {
        self.datasource = datasource
    }
    
    func fetchRepoList(for userId: String) -> AnyPublisher<[RepoDTO], Error> {
        datasource.fetchRepoList(for: userId)
    }
}
