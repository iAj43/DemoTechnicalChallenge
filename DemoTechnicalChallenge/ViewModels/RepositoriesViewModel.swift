//
//  RepositoriesViewModel.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import Foundation
import Combine

class RepositoriesViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var filteredRepositories: [Repository] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializer
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func fetchRepositories() {
        isLoading = true
        Task {
            do {
                let repositories: [Repository] = try await networkService.fetch(from: .repositories)
                updateRepositories(repositories)
            } catch {
                handleError(error)
            }
            isLoading = false
        }
    }

    func searchRepositories(with query: String) {
        filteredRepositories = query.isEmpty ? repositories : filterRepositories(by: query)
    }

    // MARK: - Private Methods

    private func updateRepositories(_ repositories: [Repository]) {
        self.repositories = repositories
        self.filteredRepositories = repositories // Initialize filtered repositories
    }

    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
    }

    private func filterRepositories(by query: String) -> [Repository] {
        return repositories.filter { repository in
            guard let name = repository.name else { return false }
            return name.lowercased().contains(query.lowercased())
        }
    }
}
