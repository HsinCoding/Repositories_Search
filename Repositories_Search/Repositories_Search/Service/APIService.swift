//
//  APIService.swift
//  Repositories_Search
//
//  Created by Starly.Chen on 11/1/23.
//

import Foundation

enum APIResult {
    case success([String: Any]?)
    case failure(Error?)

}

final class APIService {
    
    static let shared = APIService()

    var baseURL: String {
        return "https://api.github.com"
    }
    
    var path: String {
        return "/search/repositories"
    }
    
    var method: String {
        return "GET"
    }

    var url: URL {
        let urlString = baseURL + path
        return URL(string: urlString)!
    }
    
    func urlComponents(action: APIManagerActionType) -> URLComponents? {
        var urlComponents = URLComponents(string:  baseURL + path)
        var urlQueryItem: URLQueryItem
        switch action {
        case .search(let keyWords):
            urlQueryItem = URLQueryItem(name: "q", value: keyWords)
        }

        urlComponents?.queryItems = [
            urlQueryItem
        ]
        return urlComponents
    
    }

    public func request(action: APIManagerActionType, completion: @escaping (APIResult) -> Void) {
        guard let url = urlComponents(action: action)?.url?.absoluteURL else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  error == nil else {
                completion(.failure(error))
                return
            }
            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            completion(.success(responseObject))
        }
        task.resume()
    }

}


struct Student: Codable {
    var studentId: String?
    var studentName: String?
}

