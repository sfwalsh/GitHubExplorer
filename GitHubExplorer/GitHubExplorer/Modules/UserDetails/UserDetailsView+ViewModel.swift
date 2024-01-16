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
            getUserDetails
                .invoke(requestValues: .init(username: userItem.username))
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                } receiveValue: { [weak self] userDetailDTO in
                    self?.userDetail = UserDetailViewItem(from: userDetailDTO)
                }
                .store(in: &cancellables)
        }
        
        private func fetchRepoList() {
            getUserRepos.invoke(requestValues: .init(username: userItem.username))
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                } receiveValue: { [weak self] repoDTOs in
                    self?.repos = repoDTOs.map { RepoItem(from: $0) }
                }
                .store(in: &cancellables)
        }
    }
}
