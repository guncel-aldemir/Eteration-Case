//
//  NetworkManaging.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation
protocol NetworkManaging {
    func request<T: Decodable>(
        endpoint: URLRequest
    ) async throws -> T
}
