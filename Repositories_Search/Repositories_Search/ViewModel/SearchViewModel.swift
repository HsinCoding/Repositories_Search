//
//  SearchViewModel.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import Foundation

final class SearchViewModel {
    var items: [Repository] = []
    var searchItems: [Repository] = []
    var searchText: String = ""
    
//    private let coordinator: GroupCoordinatorProtocol
        
    func searchAPIHandler(items: [Repository]) {
        self.items = items
        self.searchItems = self.items.filter { $0.name.contains(searchText) }
    }
    
    init() {
    }

    func searchHandler(searchText: String) -> Bool {
        self.searchText = searchText
        var reload: Bool = true
        if searchText == "" {
            items = []
            searchItems = items
        } else {
            if items.count == 0 {
                APIManager.shared.search(keyWords: searchText)
                reload = false
            } else {
                searchItems = items.filter { $0.name.contains(searchText) }
            }
        }
        return reload
    }
    
    var reminderIsHidden: Bool {
        return searchItems.count > 0
    }
    
    var reminderText: String {
        if searchText == "" {
            return "Please try search"
        }
        return "\(searchText) \nNot Found"
    }
    
    var searchBarPlaceholderText: String {
        return "Search"
    }
    
    func showGroup(at index: Int) {
//        coordinator.present()
    }
}
import Foundation
