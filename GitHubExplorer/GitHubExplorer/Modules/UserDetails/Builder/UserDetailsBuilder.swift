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
            
            // user data stack
            let userDatasource = RemoteUserDetailDataSource(apiClient: apiClient)
            let userRepository = DefaultUserDetailRepository(dataSource: userDatasource)
            let getUserDetails = GetUserDetails(repository: userRepository)
            
            // repo data stack
            let repoDatasource = RemoteUserRepoDatasource(apiClient: apiClient)
            let repoRepository = DefaultUserRepoRepository(datasource: repoDatasource)
            let getUserRepos = GetUserRepos(repository: repoRepository)
            
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
