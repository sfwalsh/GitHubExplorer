//
//  GetUsersList.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

struct GetUsersList: UseCase {
    // GET /users
    typealias T = RequestValues
    typealias U = [UserDTO]
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func invoke(requestValues: RequestValues) -> AnyPublisher<[UserDTO], Error> {
        repository.fetchUsers(since: requestValues.since)
    }
}

extension GetUsersList {
    struct RequestValues {
        let since: Int?
    }
}
