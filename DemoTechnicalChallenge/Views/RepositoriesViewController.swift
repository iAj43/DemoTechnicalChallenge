//
//  RepositoriesViewController.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import UIKit
import Combine

class RepositoriesViewController: UIViewController {
    private var viewModel: RepositoriesViewModel?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: CellIDConstants.Repositories.repositoryCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.isHidden = true
        return indicator
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search Repositories"
        return controller
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
        bindViewModel()
        viewModel?.fetchRepositories()
    }

    // MARK: - Setup Methods

    private func setupViewModel() {
        viewModel = RepositoriesViewModel(networkService: NetworkService())
    }

    private func setupUI() {
        title = "Repositories"
        view.backgroundColor = .systemGroupedBackground
        setupSubviews()
        setupConstraints()
        setupSearchController()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicatorView)
        view.addSubview(errorLabel)
    }

    private func setupConstraints() {
        setupTableViewConstraints()
        setupLoadingIndicatorConstraints()
        setupErrorLabelConstraints()
    }

    private func setupSearchController() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - ViewModel Binding

extension RepositoriesViewController {
    private func bindViewModel() {
        bindFilteredRepositories()
        bindLoadingState()
        bindErrorMessage()
    }

    private func bindFilteredRepositories() {
        viewModel?.$filteredRepositories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func bindLoadingState() {
        viewModel?.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.loadingIndicatorView.isHidden = !isLoading
                isLoading ? self?.loadingIndicatorView.startAnimating() : self?.loadingIndicatorView.stopAnimating()
            }
            .store(in: &cancellables)
    }

    private func bindErrorMessage() {
        viewModel?.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.errorLabel.text = errorMessage
                self?.errorLabel.isHidden = errorMessage == nil
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredRepositories.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIDConstants.Repositories.repositoryCell, for: indexPath) as? RepositoryTableViewCell,
              let repository = viewModel?.filteredRepositories[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: repository)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // handle cell selection if needed
    }
}

// MARK: - UISearchResultsUpdating

extension RepositoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        viewModel?.searchRepositories(with: query)
    }
}

// MARK: - Layout Constraints

private extension RepositoriesViewController {
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupLoadingIndicatorConstraints() {
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setupErrorLabelConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loadingIndicatorView.bottomAnchor, constant: 20)
        ])
    }
}
