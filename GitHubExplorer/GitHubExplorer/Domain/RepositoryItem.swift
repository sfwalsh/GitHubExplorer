//
//  RepositoryItem.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

struct RepositoryItem: Identifiable {
    let id: String
    let title: String
    let developmentLanguage: String?
    let starCountText: String
    let description: String?
    let url: URL?
    
    init(id: String,
         title: String,
         developmentLanguage: String? = nil,
         starCountText: String,
         description: String? = nil,
         url: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.developmentLanguage = developmentLanguage
        self.starCountText = starCountText
        self.description = description
        self.url = url
    }
}
