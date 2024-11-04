//
//  NetworkService.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import Foundation
import Combine

// MARK: - Protocol defining the responsibilities of the NetworkService
protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from endpoint: APIService.Endpoint) async throws -> T
}

// MARK: - Implementation of NetworkService
class NetworkService: NetworkServiceProtocol {
    
    private let apiService: APIServiceProtocol
    
    // dependency injection through the initializer for easier testing
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetch<T: Decodable>(from endpoint: APIService.Endpoint) async throws -> T {
        let url = try buildURL(for: endpoint)
        let data = try await fetchData(from: url)
        return try decode(data: data)
    }
    
    // MARK: - Private Methods
    
    private func buildURL(for endpoint: APIService.Endpoint) throws -> URL {
        guard let url = apiService.url(for: endpoint) else {
            throw NetworkError.invalidURL
        }
        return url
    }

    private func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        return data
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unexpectedResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }

    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

// MARK: - API Errors

enum NetworkError: Error {
    case invalidURL
    case unexpectedResponse
    case serverError(statusCode: Int)
    case decodingError(Error)
}
