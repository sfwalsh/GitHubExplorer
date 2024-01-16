//
//  UserDetailsView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

extension UserDetailsView {
    final class ViewModel: ObservableObject {
        private let userItem: UserItem
        
        var titleText: String {
            userItem.username
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
                LazyVStack(alignment: .leading, spacing: 2) {
                    buildUserDetailsHeader()
//                    ForEach(viewModel.userItems) { userItem in
//                    }
                    
                }.padding(.top, 16)
            }
        }
        .navigationTitle(viewModel.titleText)
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
            }.padding(.horizontal)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    UserDetailsView(viewModel: .init(from: .init(username: "username")))
}
