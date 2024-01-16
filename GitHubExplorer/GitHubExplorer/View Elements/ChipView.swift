//
//  ChipView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

struct ChipView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(Palette.secondaryText)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Palette.accent, lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Palette.accent)
                    )
            )
    }
}

#Preview {
    ChipView(text: "Swift")
}
