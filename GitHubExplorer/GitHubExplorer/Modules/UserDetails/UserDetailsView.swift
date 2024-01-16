//
//  UserDetailsView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

struct RepositoryItem: Identifiable {
    let id: String
    let title: String
    let developmentLanguage: String?
    let starCount: Int
    let description: String?
}

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
                            developmentLanguage: "Swift",
                            starCount: 2,
                            description: nil
                        ),
                count: 1
            )
        }
        
        init(from userItem: UserItem) {
            self.userItem = userItem
        }
    }
}

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
        NavigationLink {
            
        } label: {
            ListItemView(
                viewModel: .init(
                    titleDisplayText: repositoryItem.title,
                    imageURL: nil
                )
            )
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
