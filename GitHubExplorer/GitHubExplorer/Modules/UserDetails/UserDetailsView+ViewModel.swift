//
//  UserDetailsView+ViewModel.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

extension UserDetailsView {
    final class ViewModel: ObservableObject {
        private let userItem: UserItem
        
        var titleText: String {
            userItem.username
        }
        
        var repositories: [RepositoryItem] {
            .init(
                repeating:
                        .init(
                            id: "0",
                            title: "GitHub Project",
                            url: URL(string: "https://googl.com")!
                        ),
                count: 1
            )
            .filter { $0.url != nil }
        }
        
        init(from userItem: UserItem) {
            self.userItem = userItem
        }
    }
}
