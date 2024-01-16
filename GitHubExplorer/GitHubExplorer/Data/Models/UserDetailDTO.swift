//
//  UserDetailDTO.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

struct UserDetailDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case fullName = "name"
        case avatarURL = "avatar_url"
        case followerCount = "followers"
        case followingCount = "following"
    }
    
    let username: String
    let fullName: String?
    let avatarURL: URL?
    let followerCount: Int
    let followingCount: Int
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let avatarURLString = try container.decode(String.self, forKey: .avatarURL)

        self.avatarURL = URL(string: avatarURLString)
        
        self.username = try container.decode(String.self, forKey: .username)
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        self.followerCount = try container.decode(Int.self, forKey: .followerCount)
        self.followingCount = try container.decode(Int.self, forKey: .followingCount)
    }
}
