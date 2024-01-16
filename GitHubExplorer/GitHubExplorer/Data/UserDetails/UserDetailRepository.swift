//
//  UserDetailRepository.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

protocol UserDetailRepository {
    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error>
}

struct DefaultUserDetailRepository: UserDetailRepository {
    private let dataSource: UserDetailDataSource

    init(dataSource: UserDetailDataSource) {
        self.dataSource = dataSource
    }

    func fetchUserDetails(userId: String) -> AnyPublisher<UserDetailDTO, Error> {
        dataSource.fetchUserDetails(userId: userId)
    }
}
