//
//  RepositoryDTO.swift
//  GitHubExplorer
//
//  Created by Stephen Walsh on 16/01/2024.
//

import Foundation

struct RepoDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case url = "html_url"
        case stargazersCount = "stargazers_count"
        case description
        case language
    }
    
    let name: String
    let url: URL
    let stargazersCount: Int
    let description: String?
    let language: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlString = try container.decode(String.self, forKey: .url)

        guard let url = URL(string: urlString) else {
            throw MappingError.invalidData
        }
        
        self.url = url
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? nil
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
    }
}
