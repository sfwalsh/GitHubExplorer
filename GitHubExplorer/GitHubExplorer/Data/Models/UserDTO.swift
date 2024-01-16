//
//  UserDTO.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

struct UserDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
    }
    
    let username: String
    let avatarURL: URL?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let avatarURLString = try container.decode(String.self, forKey: .avatarURL)

        self.avatarURL = URL(string: avatarURLString)
        self.username = try container.decode(String.self, forKey: .username)
    }
}
