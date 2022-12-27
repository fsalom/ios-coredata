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
    func getList(forceUpdate: Bool) async throws -> [Crypto]
}

extension CryptoUseCase: CryptoUseCaseProtocol {
    func getList(forceUpdate: Bool = false) async throws -> [Crypto] {
        do {
            let cryptos = try await self.repository.getList(forceUpdate: forceUpdate)
            return cryptos
        } catch {
            throw error
        }
    }
}
