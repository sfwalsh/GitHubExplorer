//
//  ModuleBuilder.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

protocol ModuleBuilder {
    associatedtype RequestValueType
    associatedtype ViewType
    static func build(requestValues: RequestValueType) -> ViewType?
}
