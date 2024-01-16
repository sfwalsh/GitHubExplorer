//
//  RootView.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            UserListView(viewModel: .init())
        }
        .tint(.green)
    }
}

#Preview {
    RootView()
}