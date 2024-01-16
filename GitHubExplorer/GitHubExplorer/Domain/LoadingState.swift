//
//  LoadingState.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case error(error: Error)
}
