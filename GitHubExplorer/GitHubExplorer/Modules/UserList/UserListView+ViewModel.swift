//
//  UserListView+ViewModel.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

extension UserListView {
    final class ViewModel: ObservableObject {
        let userItems: [UserItem] = [
            .init(username: "user1"),
            .init(username: "user2")
        ]
    }
}
