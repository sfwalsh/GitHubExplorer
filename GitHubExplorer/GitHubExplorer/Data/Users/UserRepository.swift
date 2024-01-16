//
//  UserRepository.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

protocol UserRepository {
    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error>
    func fetchUsers() -> AnyPublisher<[UserDTO], Error>
}

struct DefaultUserRepository: UserRepository {
    private let dataSource: UserDataSource

    init(dataSource: UserDataSource) {
        self.dataSource = dataSource
    }

    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error> {
        dataSource.fetchUserDetails(userId: userId)
    }
    
    func fetchUsers() -> AnyPublisher<[UserDTO], Error> {
        dataSource.fetchUsers()
    }
}
