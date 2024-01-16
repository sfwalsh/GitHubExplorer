//
//  UserDetailsView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    let viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    buildUserDetailsHeader()
                    Divider()
                    Section {
                        ForEach(viewModel.repositories) { repositoryItem in
                            buildRepositoryItemView(for: repositoryItem)
                        }
                    } header: {
                        Text("Repositories")
                            .font(.headline)
                    }
                }
                .padding(16)
            }
        }
        .navigationTitle(viewModel.titleText)
    }
    
    @ViewBuilder
    private func buildRepositoryItemView(for repositoryItem: RepositoryItem) -> some View {
        if let url = repositoryItem.url {
            Link(destination: url) {
                RepositoryListItemView(
                    titleText: repositoryItem.title,
                    starCountText: repositoryItem.starCountText,
                    description: repositoryItem.description, developmentLanguage: repositoryItem.developmentLanguage
                )
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func buildUserDetailsHeader() -> some View {
        HStack(alignment: .center) {
                AsyncImage(url: nil) { image in
                    image.scaledToFill()
                } placeholder: {
                    Color.green
                }
                .frame(width: 60, height: 60)
                .clipped()
                .background(Palette.listItemBackground)
                .clipShape(Circle())
                
            VStack(alignment: .leading, spacing: 8) {
                Text("Quinn Quinlan")
                    .font(.title3)
                    .bold()
                
                HStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("10")
                            .fontWeight(.bold)
                        Text("Followers")
                    }
                    VStack(alignment: .leading) {
                        Text("100")
                            .fontWeight(.bold)
                        Text("Following")
                    }
                }
            }
            .foregroundStyle(Palette.text)
            .padding(.horizontal)
        }
    }
}

#Preview {
    UserDetailsView(viewModel: .init(from: .init(username: "username")))
}
