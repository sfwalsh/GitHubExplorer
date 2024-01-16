//
//  UserDetailsBuilder.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

enum UserDetailsBuilder {
    
    struct Default: ModuleBuilder {
        
        typealias RequestValueType = RequestValues
        typealias ViewType = UserDetailsView
        
        static func build(requestValues: RequestValues) -> UserDetailsView? {
            let apiClient = DefaultAPIClient()
            let datasource = RemoteUserDetailDataSource(apiClient: apiClient)
            let repository = DefaultUserDetailRepository(dataSource: datasource)
            let getUserDetails = GetUserDetails(repository: repository)
            let getUserRepos = GetUserRepos()
            let viewModel = UserDetailsView
                .ViewModel(
                    from: requestValues.userItem,
                    getUserDetails: getUserDetails,
                    getUserRepos: getUserRepos
                )
            return UserDetailsView(viewModel: viewModel)
        }
        
        struct RequestValues { 
            let userItem: UserItem
        }
    }
}
