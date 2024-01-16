//
//  UseCase.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

protocol UseCase {
    associatedtype T
    associatedtype U: Decodable
    func invoke(requestValues: T) -> AnyPublisher<U, Error>
}
