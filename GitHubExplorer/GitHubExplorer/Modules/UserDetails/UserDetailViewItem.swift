//
//  UserDetailViewItem.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

struct UserDetailViewItem {
    
    let username: String
    let fullName: String?
    let avatarURL: URL?
    let followerCount: Int
    let followingCount: Int
    
    init(from dto: UserDetailDTO) {
        self.username = dto.username
        self.fullName = dto.fullName
        self.avatarURL = dto.avatarURL
        self.followerCount = dto.followerCount
        self.followingCount = dto.followingCount
    }
}
