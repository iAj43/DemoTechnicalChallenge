//
//  APIService.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import Foundation

// MARK: - Protocol for APIService to enhance testability
protocol APIServiceProtocol {
    func url(for endpoint: APIService.Endpoint) -> URL?
}

// MARK: - Implementation of APIService
class APIService: APIServiceProtocol {
    private let baseURL = "https://api.github.com"

    enum Endpoint {
        case repositories
        case user(username: String)
        
        var path: String {
            switch self {
            case .repositories:
                return "/orgs/square/repos"
            case .user(let username):
                return "/users/\(username)"
            }
        }
    }

    func url(for endpoint: Endpoint) -> URL? {
        guard let url = URL(string: baseURL + endpoint.path) else {
            return nil
        }
        return url
    }
}
