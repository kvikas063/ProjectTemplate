//
//  NetworkRequest.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 19/01/24.
//

import Foundation

public enum Endpoint {
    private static let BASE_URL = "https://baseurl.com/v1/api/"
    
    case login
    case logout
    case profile
    case home
}

public enum APIError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
}

public enum HTTPMethod: String
{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol HTTPRequest {
    var url: URL { get set }
    var method: HTTPMethod { get set }
}

public struct Request: HTTPRequest {
    var url: URL
    var method: HTTPMethod
    var params: String? = nil
    var requestBody: Data? = nil

    public init(
        withUrl url: URL,
        forHttpMethod method: HTTPMethod,
        params: String? = nil,
        requestBody: Data? = nil
    ) {
        self.url = url
        self.method = method
        self.params = params
        self.requestBody = requestBody
    }
}
