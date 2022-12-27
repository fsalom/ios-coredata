//
//  CryptoRepository.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation

protocol CryptoRepositoryProtocol {
    func getList(forceUpdate: Bool) async throws -> [Crypto]
}

final class CryptoRepository: CryptoRepositoryProtocol {
    private var networkClient: CryptoNetworkClientProtocol
    private var coreDataClient: CryptoCoreDataClientProtocol

    init(networkClient: CryptoNetworkClientProtocol, coreDataClient: CryptoCoreDataClientProtocol){
        self.networkClient = networkClient
        self.coreDataClient = coreDataClient
    }

    func getList(forceUpdate: Bool = false) async throws -> [Crypto] {
        do {
            let shouldUpdate = await coreDataClient.checkUpdate()
            let cryptos = await coreDataClient.getList()
            if cryptos.isEmpty || shouldUpdate || forceUpdate {
                print(forceUpdate ? "🦾 Renovación forzada" : cryptos.isEmpty ? "❗️Sin información previa" : "🚫 Información caducada")

                let cryptoDTOs = try await networkClient.getList()
                var cryptos = [Crypto]()
                cryptoDTOs.forEach { cryptoDTO in
                    cryptos.append(Crypto(dto: cryptoDTO))
                }
                coreDataClient.updateList(with: cryptos)
                return cryptos
            } else {
                print("🗄 Recuperando información guardada. Cryptos: \(cryptos.count)")

                return Array(cryptos)
            }
        } catch {
            throw error
        }
    }
}
