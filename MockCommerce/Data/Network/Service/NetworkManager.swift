//
//  NetworkManager.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation


final class NetworkManager: NetworkManaging{
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    func request<T>(endpoint: URLRequest) async throws -> T where T : Decodable {
        let (data, response) = try await urlSession.data(for: endpoint)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }
        
        do {
            let decodeData = try JSONDecoder().decode(T.self, from: data)
            return decodeData
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    
}
