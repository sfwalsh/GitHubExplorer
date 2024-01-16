//
//  UserListBuilder.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

enum UserListBuilder {
    
    struct Default: ModuleBuilder {
        
        typealias RequestValueType = RequestValues
        typealias ViewType = UserListView
        
        static func build(requestValues: RequestValues) -> UserListView? {
            UserListView(viewModel: .init())
        }
        
        struct RequestValues { }
    }
}
