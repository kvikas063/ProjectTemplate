//
//  NetworkManager.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // Using Completion Block Method
    func request<T:Decodable>(
        with urlRequest: Request,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        let request = createURLRequest(with: urlRequest)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        .resume()
    }
    
    // Using Async Await Method
    func request<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.invalidData
        }
    }
    
    private func createURLRequest(with request: Request) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        if let params = request.params {
            let url = request.url.absoluteString + "?" + params
            urlRequest.url = URL(string: url)
        }
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.requestBody
        return urlRequest
    }
}
