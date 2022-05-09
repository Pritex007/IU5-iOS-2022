//
//  NetworkService.swift
//  LABS
//
//  Created by Погиблов on 08.04.2022.
//

import Foundation

enum HTTPRequestType: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkRequestFactoryProtocol {
    func getTopCoinsRequest() -> URLRequest
}

final class NetworkRequestFactory: NetworkRequestFactoryProtocol {
    
    private enum Constants {
        static let apiKey = "b3274e01-fd44-48db-8f86-b5d77c17a1a2"
        static let baseURL = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest")!
    }
    
    func getTopCoinsRequest() -> URLRequest {
        let requestURL = Constants.baseURL
        
        var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: String(6)),
            URLQueryItem(name: "convert", value: "USD")
        ]

        guard let url = urlComponents?.url else {
            assertionFailure("Request cryptoData error")
            return URLRequest(url: URL(string: "")!)
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Accept":"application/json", "X-CMC_PRO_API_KEY": Constants.apiKey]
        
        request.httpMethod = HTTPRequestType.get.rawValue
        
        return request
    }
    
}
