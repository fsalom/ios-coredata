//
//  cryptoNetwork.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation


enum CryptoNetworkError: Error{
    case badURL
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}

protocol CryptoNetworkClientProtocol {
    func getList() async throws -> [CryptoDTO]
}

class CryptoNetworkClient {
    init() { }
}

extension CryptoNetworkClient: CryptoNetworkClientProtocol {
    func getList() async throws -> [CryptoDTO] {
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else {
            throw CryptoNetworkError.badURL
        }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw CryptoNetworkError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    let json = try decoder.decode(DataNetworkResponse<[CryptoDTO]>.self, from: data)
                    print("☎️ Llamada para obtener \(json.data?.count ?? 0) cryptos")                    
                    return json.data ?? []
                } else {
                    throw CryptoNetworkError.badResponse
                }
            } catch {
                throw CryptoNetworkError.decodeError
            }
        } catch {
            throw CryptoNetworkError.badRequest
        }
    }
}
