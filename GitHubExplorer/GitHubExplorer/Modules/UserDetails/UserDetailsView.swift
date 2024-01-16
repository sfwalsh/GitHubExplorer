//
//  UserDetailsView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

struct UserDetailsView: View {
    
    private enum Strings {
        static let following = "Following"
        static let followers = "Followers"
        static let fullnamePlaceholder = "User"
        static let repositoriesSectionTitle = "Repositories"
        static let emptyStateText = "No Repos were found."
    }
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    buildHeaderView()
                    Divider()
                    Section {
                        buildRepositoryCollectionView()
                    } header: {
                        Text(Strings.repositoriesSectionTitle)
                            .font(.headline)
                    }
                }
                .padding(16)
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
        .navigationTitle(viewModel.titleText)
    }
    
    // MARK: Sub-builders
    
    @ViewBuilder
    private func buildProgressView() -> some View {
        HStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    @ViewBuilder
    private func buildHeaderView() -> some View {
        switch viewModel.userFetchState {
        case .idle:
            if let userDetail = viewModel.userDetail {
               buildUserDetailsHeader(for: userDetail)
            } else {
                EmptyView()
            }
        case .loading:
            buildProgressView()
        case .error(let error):
            EmptyView() // TODO: Build error view
        }
    }
    
    @ViewBuilder
    private func buildEmptyStateView(with text: String) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 16) {
                Spacer()
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .frame(width: 32, height: 32)
                Text(text)
                    .font(.title2)
                Spacer()
            }
            Spacer()
        }   
    }
    
    @ViewBuilder
    private func buildRepositoryCollectionView() -> some View {
        switch viewModel.repoFetchState {
        case .idle:
            if viewModel.repos.count > 0 {
                ForEach(viewModel.repos) { repositoryItem in
                    buildRepositoryItemView(for: repositoryItem)
                }
            } else {
                buildEmptyStateView(with: Strings.emptyStateText)
            }
        case .loading:
            buildProgressView()
        case .error(let error):
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func buildRepositoryItemView(for repositoryItem: RepoItem) -> some View {
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
    private func buildUserDetailsHeader(for userDetail: UserDetailViewItem) -> some View {
        HStack(alignment: .center) {
            AsyncImage(url: userDetail.avatarURL) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Image(systemName: "person.fill")
                    .scaledToFill()
                    .foregroundStyle(Palette.text)
            }
            .frame(width: 60, height: 60)
            .clipped()
            .background(Palette.listItemBackground)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(userDetail.fullName ?? Strings.fullnamePlaceholder)
                    .font(.title3)
                    .bold()
                
                HStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("\(userDetail.followerCount)")
                            .fontWeight(.bold)
                        Text(Strings.followers)
                    }
                    VStack(alignment: .leading) {
                        Text("\(userDetail.followingCount)")
                            .fontWeight(.bold)
                        Text(Strings.following)
                    }
                }
            }
            .foregroundStyle(Palette.text)
            .padding(.horizontal)
        }
    }
}

#Preview {
    let item = UserItem(username: "sfwalsh")
    return UserDetailsBuilder.Default.build(requestValues: .init(userItem: item))
}
