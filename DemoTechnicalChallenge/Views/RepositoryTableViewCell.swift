//
//  RepositoryTableViewCell.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let ownerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let repoNameLabel: UILabel = {
        let label = UILabel()
        label.configureAsRepoNameLabel()
        return label
    }()
    
    private let repoFullNameLabel: UILabel = {
        let label = UILabel()
        label.configureAsDescriptionLabel()
        return label
    }()
    
    private let repoDescLabel: UILabel = {
        let label = UILabel()
        label.configureAsRepoDescLabel()
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .customSeparatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageCache = ImageCache()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with repository: Repository) {
        repoNameLabel.text = repository.name
        repoFullNameLabel.text = repository.fullName
        repoDescLabel.text = repository.description
        loadImageIfNeeded(for: repository)
    }
}

// MARK: - Image loading
private extension RepositoryTableViewCell {
    private func loadImageIfNeeded(for repository: Repository) {
        guard let avatarURLString = repository.owner?.avatarUrl,
              let avatarURL = URL(string: avatarURLString) else { return }
        loadImage(from: avatarURL)
    }
    
    private func loadImage(from url: URL) {
        Task {
            do {
                let image = try await imageCache.loadImage(from: url)
                DispatchQueue.main.async {
                    self.ownerImageView.image = image
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
}

// MARK: - UILabel Extensions for Configuration
private extension UILabel {
    func configureAsRepoNameLabel() {
        font = UIFont.boldSystemFont(ofSize: 18)
        numberOfLines = 1
        textColor = .customTextColor
    }
    
    func configureAsDescriptionLabel() {
        font = UIFont.systemFont(ofSize: 14)
        numberOfLines = 2
        textColor = .customDescriptionTextColor
    }
    
    func configureAsRepoDescLabel() {
        font = UIFont.italicSystemFont(ofSize: 12)
        textColor = .tertiaryLabel
        numberOfLines = 0 // Allow multiple lines
    }
}

// MARK: - Setup Views & Constraints
private extension RepositoryTableViewCell {
    private func setupViews() {
        backgroundColor = .systemBackground
        selectionStyle = .none
        contentView.addSubview(ownerImageView)
        contentView.addSubview(repoNameLabel)
        contentView.addSubview(repoFullNameLabel)
        contentView.addSubview(repoDescLabel)
        contentView.addSubview(separatorView)
    }
    
    func setupConstraints() {
        ownerImageView.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoDescLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ownerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            ownerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ownerImageView.widthAnchor.constraint(equalToConstant: 30),
            ownerImageView.heightAnchor.constraint(equalToConstant: 30),
            
            repoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            repoNameLabel.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 10),
            repoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            repoFullNameLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 5),
            repoFullNameLabel.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 10),
            repoFullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            repoDescLabel.topAnchor.constraint(equalTo: repoFullNameLabel.bottomAnchor, constant: 5),
            repoDescLabel.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 10),
            repoDescLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            repoDescLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
