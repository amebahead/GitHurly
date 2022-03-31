//
//  APICaller.swift
//  GitHurly
//
//  Created by MacDole on 2022/03/31.
//

import Foundation
import UIKit

// Network API Class
final class APICaller {
    // Singleton
    public static let shared = APICaller()
    public private(set) var isLoading: Bool = false     // 중복 api call을 막기 위해 isLoading 상태 체크
    
    // Constant
    private struct Constants {
        static let baseUrl = "https://api.github.com/"
    }
    
    // Private Constructor
    private init() {}
    
    // API EndPoints
    private enum Endpoint: String {
        case search = "search/repositories"
    }
    
    // API Errors
    private enum APIError: Error {
        case noDataReturned
        case invalidUrl
    }
    
    // Create Url
    private func url (for endpoint: Endpoint, queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseUrl + endpoint.rawValue
        var queryItems = [URLQueryItem]()
        
        // Add any parameters
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        return URL(string: urlString)
    }
    
    // Api Request
    private func request<T: Codable> (url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if isLoading { return }
        isLoading = true
        
        guard let url = url else {
            // Invalid url
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        print(url.debugDescription)
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            self.isLoading = false
            
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                print(String(decoding: data, as: UTF8.self))
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

extension APICaller {
    // Search for a Repository
    public func search(query: String, page: Int, completion: @escaping (Result<Repository, Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let page = String(page)
        
        request(url: url(for: .search, queryParams: ["q": safeQuery, "page": page, "per_page": "5"]),
            expecting: Repository.self,
            completion: completion)
    }
}

