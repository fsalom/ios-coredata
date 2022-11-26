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
            let cryptos = await AppDelegate.sharedAppDelegate.coreDataManager.fetchCryptos()
            if cryptos.isEmpty {
                let cryptoDTOs = try await networkClient.getList()
                var cryptos = [Crypto]()
                cryptoDTOs.forEach { cryptoDTO in
                    cryptos.append(Crypto(dto: cryptoDTO))
                }
                await saveCoreData(this: cryptos)
                return cryptos
            } else {
                return Array(cryptos)
            }
        } catch {
            throw error
        }
    }

    func saveCoreData(this cryptos: [Crypto]) async {
        await AppDelegate.sharedAppDelegate.coreDataManager.save(this: cryptos)
    }
}
