//
//  UserItem.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

struct UserItem: Identifiable {
    var id: String { username }
    let username: String
    let imageURL: URL?
    
    init(username: String, imageURL: URL? = nil) {
        self.username = username
        self.imageURL = imageURL
    }
}
