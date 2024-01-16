//
//  UserListView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

struct UserItem: Identifiable {
    var id: String { username }
    let username: String
    let imageURL: URL?
    
    init(username: String, imageURL: URL? = nil) {
        self.username = username
        self.imageURL = imageURL
    }
}

extension UserListView {
    final class ViewModel: ObservableObject {
        let userItems: [UserItem] = [
            .init(username: "user1"),
            .init(username: "user2")
        ]
    }
}

struct UserListView: View {
    
    let viewModel: ViewModel
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.userItems) { userItem in
                        buildItemView(forUserItem: userItem)
                    }
                }.padding(.top, 16)
            }
        }
        .navigationTitle("Users")
    }
    
    @ViewBuilder
    private func buildItemView(forUserItem userItem: UserItem) -> some View {
        NavigationLink {
            UserDetailsView(viewModel: .init(from: userItem))
        } label: {
            ListItemView(
                viewModel: .init(
                    titleDisplayText: userItem.username,
                    imageURL: userItem.imageURL
                )
            )
        }
    }
}

#Preview {
    UserListView(viewModel: .init())
}
