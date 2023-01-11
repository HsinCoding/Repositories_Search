//
//  SearchViewController.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import UIKit

final class SearchViewController: UIViewController {

    private let tableView = UITableView()
    private let reminderLabel = UILabel()
    private let emptyImageView = UIImageView()
    private let searchBar = UISearchBar()
    private var viewModel: SearchViewModel?
    lazy var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let groupCoordinator = GroupCoordinator(navigationController: navigationController)
        self.viewModel = .init()
        setupDelegate()
        setupViews()
        setupHierarchy()
        setupConstraints()
        updateUI()
    }
    
    private func setupDelegate() {
        APIManager.shared.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func setupViews() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.style = .large
        activityIndicator.center = self.view.center
        reminderLabel.numberOfLines = 0
        reminderLabel.textAlignment = .center
        searchBar.placeholder = viewModel?.searchBarPlaceholderText
        
        
        reminderLabel.backgroundColor = .green
        emptyImageView.backgroundColor = .blue
       
    }
    
    private func setupHierarchy() {
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
        self.tableView.addSubview(reminderLabel)
        self.tableView.addSubview(emptyImageView)
        searchBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
        tableView.tableHeaderView = searchBar
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            reminderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            reminderLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emptyImageView.bottomAnchor.constraint(lessThanOrEqualTo: reminderLabel.topAnchor, constant: -16),
            emptyImageView.widthAnchor.constraint(equalToConstant: 100),
            emptyImageView.heightAnchor.constraint(equalTo: emptyImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    func updateUI() {
        self.emptyImageView.isHidden = viewModel?.reminderIsHidden ?? true
        self.reminderLabel.isHidden = viewModel?.reminderIsHidden ?? true
        self.reminderLabel.text = viewModel?.reminderText
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ResultTableViewCell()
        if let model = viewModel?.searchItems[indexPath.row] {
            let viewModel: ResultTableViewCell.ViewModel = .init(
                id: model.id,
                name: model.name,
                fullName: model.fullName,
                isPrivate: model.isPrivate,
                avatarURL: model.avatarURL
            )
            cell.configure(with: viewModel)
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let vc = WebViewController()
        vc.view.backgroundColor = .red
//        self.pushViewController(vc, animated: true)
        self.present(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.viewModel?.searchHandler(searchText: searchText) == true {
            updateUI()
            tableView.reloadData()
        } else {
            activityIndicator.startAnimating()
        }
    }
}

extension SearchViewController: APIManagerDelegate {
    func search(_presenter: APIManager, model: RepositoriesModel) {
        self.viewModel?.searchAPIHandler(items: model.items)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.updateUI()
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}


