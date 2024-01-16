//
//  RepositoryListItemView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation
import SwiftUI

struct RepositoryListItemView: View {
    
    let titleText: String
    let starCountText: String
    let description: String?
    let developmentLanguage: String?
    
    var body: some View {
        HStack(spacing: 16) {
            buildTextContent()
            Spacer()
            Image(systemName: "arrow.forward")
                .font(.system(size: 17.0))
                .foregroundColor(Palette.text)
        }
        .padding(16)
        .background(
            ListItemViewBackground()
        )
    }
    
    @ViewBuilder
    private func buildTextContent() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            buildTitleText()
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .foregroundColor(Palette.text)
            
            if let description = description {
                Text(description)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Palette.text).lineLimit(2)
            }
            
            if let developmentLanguage = developmentLanguage {
                ChipView(text: developmentLanguage)
            }
        }
    }
    
    private func buildTitleText() -> Text {
        Text("\(titleText) • ")
        +
        Text(Image(systemName: "star"))
        +
        Text(" \(starCountText)")
    }
}

#Preview {
    RepositoryListItemView(
        titleText: "GitHubGiggles",
        starCountText: "2.5K",
        description: "Get ready to embark on a coding adventure like never before with GitHubGiggles – the side-splitting app designed for developers who believe laughter is the best debugging tool.",
        developmentLanguage: "Swift"
    )
}

