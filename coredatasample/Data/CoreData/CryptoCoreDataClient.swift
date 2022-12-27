//
//  CoreDataClient.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 27/12/22.
//

import Foundation

protocol CryptoCoreDataClientProtocol {
    func getList() async -> [Crypto]
    func checkUpdate() async -> Bool 
    func updateList(with cryptos: [Crypto])
}

class CryptoCoreDataClientClient {

    init() { }
}

extension CryptoCoreDataClientClient: CryptoCoreDataClientProtocol {
    func updateList(with cryptos: [Crypto]) {
        Container.shared.coreDataManager.deleteCryptos()
        Container.shared.coreDataManager.save(this: cryptos)
    }

    func getList() async -> [Crypto] {
        return await withCheckedContinuation { continuation in
            Container.shared.coreDataManager.fetchCryptos(result: { cryptos in
                continuation.resume(returning: Array(cryptos))
            })
        }
    }

    func checkUpdate() async -> Bool {
        return await withCheckedContinuation { contiuation in
            Container.shared.coreDataManager.shouldUpdate(this: "Crypto") { result in
                contiuation.resume(returning: result)
            }
        }
    }
}
