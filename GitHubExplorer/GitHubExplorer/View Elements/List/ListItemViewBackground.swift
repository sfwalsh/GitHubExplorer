//
//  ListItemViewBackground.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

struct ListItemViewBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Palette.listItemBackground)
            .shadow(
                color: Palette.shadow,
                radius: 5,
                y: 1
            )
    }
}

#Preview {
    ListItemViewBackground()
}
