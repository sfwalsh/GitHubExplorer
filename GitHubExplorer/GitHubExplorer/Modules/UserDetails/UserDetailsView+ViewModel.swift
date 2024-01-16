//
//  UserDetailsView+ViewModel.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import Combine

extension UserDetailsView {
    final class ViewModel: ObservableObject {
        private let userItem: UserItem
        
        // MARK: Use Cases
        private let getUserDetails: GetUserDetails
        private let getUserRepos: GetUserRepos
        
        var titleText: String {
            userItem.username
        }
        
        @Published var userFetchState: LoadingState = .idle
        @Published var repoFetchState: LoadingState = .idle
        
        @Published var userDetail: UserDetailViewItem?
        @Published var repos: [RepoItem] = []
        
        private var cancellables: Set<AnyCancellable> = []
        
        init(
            from userItem: UserItem,
            getUserDetails: GetUserDetails,
            getUserRepos: GetUserRepos
        ) {
            self.userItem = userItem
            self.getUserDetails = getUserDetails
            self.getUserRepos = getUserRepos
        }
        
        func fetchData() {
            fetchUserDetails()
            fetchRepoList()
        }
        
        private func fetchUserDetails() {
            guard case .idle = userFetchState else {
                return
            }
            userFetchState = .loading
        
            getUserDetails
                .invoke(requestValues: .init(username: userItem.username))
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.userFetchState = .idle
                    case .failure(let error):
                        self?.userFetchState = .error(error: error)
                    }
                } receiveValue: { [weak self] userDetailDTO in
                    self?.userDetail = UserDetailViewItem(from: userDetailDTO)
                }
                .store(in: &cancellables)
        }
        
        private func fetchRepoList() {
            guard case .idle = repoFetchState else {
                return
            }

            repoFetchState = .loading
            getUserRepos.invoke(requestValues: .init(username: userItem.username))
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.repoFetchState = .idle
                    case .failure(let error):
                        self?.repoFetchState = .error(error: error)
                    }
                } receiveValue: { [weak self] repoDTOs in
                    self?.repos = repoDTOs.map { RepoItem(from: $0) }
                }
                .store(in: &cancellables)
        }
    }
}
