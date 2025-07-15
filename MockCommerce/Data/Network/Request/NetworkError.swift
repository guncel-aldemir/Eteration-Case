//
//  NetworkError.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case statusCode(Int)
    case unknown
}
