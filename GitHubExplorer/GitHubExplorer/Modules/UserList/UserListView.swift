//
//  UserListView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

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
            UserDetailsBuilder.Default
                .build(requestValues: .init(userItem: userItem))
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
