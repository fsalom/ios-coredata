//
//  CryptoUseCase.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation

enum CryptoUseCaseError: Error{
    case badURL
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}

final class CryptoUseCase {
    let repository: CryptoRepositoryProtocol

    init(repository: CryptoRepositoryProtocol) {
        self.repository = repository
    }
}

protocol CryptoUseCaseProtocol {
    func getList() async throws -> [Crypto]
}

extension CryptoUseCase: CryptoUseCaseProtocol {
    func getList() async throws -> [Crypto] {
        do {
            let cryptos = try await self.repository.getList()
            return cryptos
        } catch {
            throw error
        }
    }
}
