//
//  RepoItem.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

struct RepoItem: Identifiable {
    let id: String
    let title: String
    let developmentLanguage: String?
    let starCountText: String
    let description: String?
    let url: URL?
    
    init(from dto: RepoDTO) {
        self.id = dto.name
        self.title = dto.name
        self.developmentLanguage = dto.language
        self.starCountText = "\(dto.stargazersCount)" // TODO: number formatter
        self.description = dto.description
        self.url = dto.url
    }
}
