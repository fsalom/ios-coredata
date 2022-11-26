//
//  CryptoDM.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 26/11/22.
//

import Foundation
import CoreData
import UIKit

extension CoreDataManager {
    // MARK: Fetch Products
    func fetchCryptos() -> Set<Crypto> {
        let fetchRequest: NSFetchRequest<CryptoDM> = CryptoDM.fetchRequest()
        do {
            let cryptosDM = try managedContext.fetch(fetchRequest)
            var cryptos: Set<Crypto> = []

            for cryptoDM in cryptosDM {
                let (inserted, memberAfterInsert) = cryptos.insert(Crypto(name: cryptoDM.name ?? "",
                                                                          priceUsd: cryptoDM.priceUsd ?? "",
                                                                          changePercent24Hr: cryptoDM.changePercent24Hr ?? ""))
                if !inserted {
                    print("Crypto \(memberAfterInsert) already exists")
                }
            }

            return cryptos
        } catch {
            print("Error fething the literals - \(error)")
        }
        return []
    }


    func save(this cryptos: [Crypto]) {
        for crypto in cryptos {
            let cryptoDM = CryptoDM(context: managedContext)
            cryptoDM.name = crypto.name
            cryptoDM.priceUsd = crypto.priceUsd
            cryptoDM.changePercent24Hr = crypto.changePercent24Hr
            print("Crypto \(cryptoDM.name) saved")
        }

        saveContext()
    }
}
