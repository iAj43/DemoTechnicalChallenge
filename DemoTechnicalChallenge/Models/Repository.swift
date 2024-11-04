//
//  Repository.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import Foundation

// MARK: - Repository Model
class Repository: Codable {
    let id: Int?
    let name: String?
    let fullName: String?
    let description: String?
    let owner: Owner?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case owner
    }
}

// MARK: - Owner Model
class Owner: Codable {
    let id: Int?
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
    }
}
