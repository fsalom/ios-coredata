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
    func fetchCryptos(result: @escaping (Set<Crypto>) -> Void) {
        DispatchQueue.main.async {
            let fetchRequest: NSFetchRequest<CryptoDM> = CryptoDM.fetchRequest()
            do {
                let cryptosDM = try self.managedContext.fetch(fetchRequest)
                var cryptos: Set<Crypto> = []
                for cryptoDM in cryptosDM {
                    let (inserted, memberAfterInsert) = cryptos.insert(Crypto(name: cryptoDM.name ?? "",
                                                                              priceUsd: cryptoDM.priceUsd ?? "",
                                                                              changePercent24Hr: cryptoDM.changePercent24Hr ?? ""))
                    if !inserted {
                        print("Crypto \(memberAfterInsert) already exists")
                    }
                }
                result(cryptos)
            } catch {
                print("Error fething cryptos - \(error)")
                result([])
            }
        }
    }


    func save(this cryptos: [Crypto]) {
        DispatchQueue.main.async {
            print("📥 Save \(cryptos.count) cryptos")
            for crypto in cryptos {
                let cryptoDM = CryptoDM(context: self.managedContext)
                cryptoDM.name = crypto.name
                cryptoDM.priceUsd = crypto.priceUsd
                cryptoDM.changePercent24Hr = crypto.changePercent24Hr
            }
            self.update(this: "Crypto")
            self.saveContext()
        }
    }

    func deleteCryptos() {
        DispatchQueue.main.async {
            let fetchRequest: NSFetchRequest<CryptoDM> = CryptoDM.fetchRequest()
            let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

            do {
                try self.managedContext.execute(deleteBatch)
                print("🗑 Success deleting cryptos")
            } catch {
                print("Error deleting cryptos \(error)")
            }
        }
    }
}
