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
            let apiClient = DefaultAPIClient()
            let userDatasource = RemoteUserDataSource(apiClient: apiClient)
            let userRepository = DefaultUserRepository(dataSource: userDatasource)
            let getUsersList = GetUsersList(repository: userRepository)
            let viewModel = UserListView.ViewModel(userItems: [], getUsersList: getUsersList)
            
            return UserListView(viewModel: viewModel)
        }
        
        struct RequestValues { }
    }
}
