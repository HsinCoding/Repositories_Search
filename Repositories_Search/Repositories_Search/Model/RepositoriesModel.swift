//
//  RepositoriesModel.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import Foundation

struct RepositoriesModel {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
}

struct Repository {
    let id: Int
    let name: String
    let fullName: String
    let isPrivate: Bool
    let avatarURL: String
    let htmlURLString: String
}
