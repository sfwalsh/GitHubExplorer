//
//  GetUserDetails.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

struct GetUserDetails: UseCase {
    // GET /users/*
    typealias T = RequestValues
    typealias U = UserDetailDTO
    
    private let repository: UserDetailRepository
    
    init(repository: UserDetailRepository) {
        self.repository = repository
    }
    
    func invoke(requestValues: RequestValues) -> AnyPublisher<UserDetailDTO, Error> {
        repository.fetchUserDetails(userId: requestValues.username)
    }
}


extension GetUserDetails {
    struct RequestValues {
        let username: String
    }
}
