//
//  CryptoRepository.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation

enum CryptoRepositoryError: Error{
    case badURL
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}

protocol CryptoRepositoryProtocol {
    func getList() async throws -> [CryptoDTO]
}

final class CryptoRepository: CryptoRepositoryProtocol {
    func getList() async throws -> [CryptoDTO] {
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else {
            throw CryptoRepositoryError.badURL
        }
        let request = URLRequest(url: url)
        print(request)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw CryptoRepositoryError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    return try decoder.decode([CryptoDTO].self, from: data)
                } else {
                    throw CryptoRepositoryError.badResponse
                }
            } catch {
                throw CryptoRepositoryError.decodeError
            }
        } catch {
            throw CryptoRepositoryError.badRequest
        }
    }
}
