//
//  APIManager.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import Foundation
import UIKit

protocol APIManagerDelegate: AnyObject {
    func search(_presenter: APIManager, model: RepositoriesModel)
}

final class APIManager {

    weak var delegate: APIManagerDelegate?
    static let shared = APIManager()
    private var api = APIService.shared
    var itemsArray: Array<Dictionary<String, Double>> = []
   
    
    func search(keyWords: String) {
        api.request(action: .search(keyWords: keyWords) ) { result in
            switch result {
            case .success(let response):
                guard let totalCount =  response?[ObjectKeys.totalCount.rawValue] as? Int else { return }
                guard let incompleteResults = response?[ObjectKeys.incompleteResults.rawValue] as? Bool else { return }
                guard let dic = response?[ObjectKeys.items.rawValue] as? Array<AnyObject> else { return }
                var items: [Repository] = []
                for item in dic {
                    guard let id = item[ObjectKeys.id.rawValue] as? Int else { return }
                    guard let name = item[ObjectKeys.name.rawValue] as? String else { return }
                    guard let isPrivate = item[ObjectKeys.isPrivate.rawValue] as? Bool else { return }
                    guard let fullName = item[ObjectKeys.fullName.rawValue] as? String else { return }
                    guard let owner = item[ObjectKeys.owner.rawValue] as? [String: Any] else { return }
                    guard let avatarURL = owner[ObjectKeys.avatarURL.rawValue] as? String else { return }
                    items.append(.init(
                        id: id,
                        name: name,
                        fullName: fullName,
                        isPrivate: isPrivate,
                        avatarURL: avatarURL
                    ))
                }
                let model = RepositoriesModel(totalCount: totalCount, incompleteResults: incompleteResults, items: items)
                self.delegate?.search(_presenter: self, model: model)
            case .failure(let error):
                print(error)
            }
        }
    }
}

