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
    func invoke(requestValues: RequestValues) -> AnyPublisher<UserDetailDTO, Error> {
        Fail(error: NSError(domain: "", code: 0))
            .eraseToAnyPublisher()
    }
}


extension GetUserDetails {
    struct RequestValues {
        let username: String
    }
}
