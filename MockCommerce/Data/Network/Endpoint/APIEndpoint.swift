//
//  APIEndpoint.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation

struct APIEndpoint {
    static let baseURL = "https://5fc9346b2af77700165ae514.mockapi.io"
    
    static func getProducts() -> URLRequest? {
        try? RequestBuilder.buildRequest(baseURL: baseURL, path: "/products", method: .get)
    }
}
