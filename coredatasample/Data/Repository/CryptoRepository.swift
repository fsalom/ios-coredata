//
//  CryptoRepository.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation

protocol CryptoRepositoryProtocol {
    func getList() async throws -> [Crypto]
}

final class CryptoRepository: CryptoRepositoryProtocol {
    private var networkClient: CryptoNetworkClientProtocol

    init(networkClient: CryptoNetworkClientProtocol){
        self.networkClient = networkClient
    }

    func getList() async throws -> [Crypto] {
        do {
            let shouldUpdate = Container.shared.coreDataManager.shouldUpdate(this: "Crypto")
            let cryptos = Container.shared.coreDataManager.fetchCryptos()
            if cryptos.isEmpty || shouldUpdate {
                let cryptoDTOs = try await networkClient.getList()
                var cryptos = [Crypto]()
                cryptoDTOs.forEach { cryptoDTO in
                    cryptos.append(Crypto(dto: cryptoDTO))
                }
                Container.shared.coreDataManager.deleteCryptos()
                Container.shared.coreDataManager.save(this: cryptos)
                return cryptos
            } else {
                return Array(cryptos)
            }
        } catch {
            throw error
        }
    }
}
