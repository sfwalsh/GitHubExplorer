//
//  ListItemView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import SwiftUI

struct ListItemViewModel {
    let titleDisplayText: String
    let imageURL: URL?
}

struct ListItemView: View {
    let viewModel: ListItemViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            buildImageContent()
            buildTextContent()
            
            Spacer()
            
            Image(systemName: "arrow.forward")
                .font(.system(size: 17.0))
                .foregroundColor(Color.gray)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Palette.listItemBackground)
                .shadow(
                    color: Palette.shadow,
                    radius: 5,
                    y: 1
                )
        )
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
    
    // MARK: Sub view builder functions
    @ViewBuilder
    private func buildImageContent() -> some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: viewModel.imageURL) { image in
                image.scaledToFill()
            } placeholder: {
                Color.green
            }
            .frame(width: 48, height: 48)
            .clipped()
            .background(Palette.listItemBackground)
            .clipShape(Circle())
        }
    }
    
    @ViewBuilder
    private func buildTextContent() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.titleDisplayText)
                .font(
                    .system(
                        size: 17,
                        weight: .semibold,
                        design: .default
                    )
                )
                .multilineTextAlignment(.leading)
                .foregroundColor(Palette.text)
        }
    }
}

#Preview {
    ListItemView(viewModel:
            .init(titleDisplayText: "Username",
                  imageURL: .init(string: "https://unsplash.com/photos/dcR7IIv1yOo/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8MTV8fGhhbmRzJTIwZHJpbmslMjB3b21hbnxlbnwwfHx8fDE3MDU0MTI3MjV8MA&force=true&w=64sds0"))
    )
}

