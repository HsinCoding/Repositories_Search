//
//  ResultTableViewCell.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import UIKit

final class ResultTableViewCell: UITableViewCell {

    private let avatarsImage = UIImageView()
    private let stackView =  UIStackView()
    private let nameLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let privateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .purple
        avatarsImage.backgroundColor = .yellow
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarsImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        privateLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
    }
    
    func setupHierarchy() {
        self.addSubview(avatarsImage)
        self.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(fullNameLabel)
        stackView.addArrangedSubview(privateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.layoutContentInset),
            avatarsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.layoutContentInset),
            avatarsImage.widthAnchor.constraint(equalToConstant: Constants.avatarsImageWidth),
            avatarsImage.heightAnchor.constraint(equalTo: avatarsImage.widthAnchor, multiplier: Constants.avatarsRatio),
            avatarsImage.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -Constants.layoutContentInset)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.avatarsImage.trailingAnchor, constant: Constants.layoutContentInset),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.layoutContentInset),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.layoutContentInset)
        ])
    }
    
    func configure(with viewModel: ViewModel) {
        self.nameLabel.text = viewModel.name
        self.fullNameLabel.text = viewModel.fullName
        self.privateLabel.text = String(viewModel.isPrivate)
        self.avatarsImage.downloaded(from: viewModel.avatarURL)
    }
}

extension ResultTableViewCell {
    private enum Constants {
        static let layoutContentInset: CGFloat = 16
        static let avatarsImageWidth: CGFloat = 100
        static let avatarsRatio: CGFloat = 1
    }
}

extension ResultTableViewCell {
    struct ViewModel {
        let id: Int
        let name: String
        let fullName: String
        let isPrivate: Bool
        let avatarURL: String
    }
}

