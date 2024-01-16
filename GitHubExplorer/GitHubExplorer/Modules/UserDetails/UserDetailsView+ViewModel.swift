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

        var repositories: [RepositoryItem] {
            .init(
                repeating:
                        .init(
                            id: "0",
                            title: "GitHub Project",
                            developmentLanguage: "Swift",
                            starCountText: "2", url: URL(string: "https://googl.com")!
                        ),
                count: 1
            )
            .filter { $0.url != nil }
        }
        
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
            getUserDetails
                .invoke(requestValues: .init(username: userItem.username))
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                } receiveValue: { [weak self] userDetailDTO in
                    print(userDetailDTO)
                    self?.userDetail = UserDetailViewItem(from: userDetailDTO)
                }
                .store(in: &cancellables)
        }
    }
}
