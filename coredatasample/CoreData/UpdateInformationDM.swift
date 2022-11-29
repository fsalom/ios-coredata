//
//  UpdateInformationDM.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 28/11/22.
//

import Foundation
import CoreData

extension CoreDataManager {

    func shouldUpdate(this name: String) -> Bool {
        let fetchRequest: NSFetchRequest<UpdateInformationDM> = UpdateInformationDM.fetchRequest()
        let informationPredicate = NSPredicate(format: "name == %@", name as String)
        fetchRequest.predicate = informationPredicate

        do {
            let results = try self.managedContext.fetch(fetchRequest)
            if let result = results.first {
                return isExpired(this: result.date ?? "\(Date())")
            }else{
                return true
            }
        } catch {
            print("Error createOrUpdate the products - \(error)")
            return true
        }
    }

    func isExpired(this date: String) -> Bool {
        let expiryDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        return Date() < dateFormatter.date(from: expiryDate) ?? Date() ? false : true
    }

    func save(this updateInformations: [UpdateInformation]) {
        for updateInformation in updateInformations {
            let fetchRequest: NSFetchRequest<UpdateInformationDM> = UpdateInformationDM.fetchRequest()
            let informationPredicate = NSPredicate(format: "name == %@", updateInformation.name as String)
            fetchRequest.predicate = informationPredicate

            do {
                let results = try self.managedContext.fetch(fetchRequest)
                if results.count == 0 {
                    let updateInformationDM = UpdateInformationDM(context: managedContext)
                    updateInformationDM.name = updateInformation.name
                    updateInformationDM.date = updateInformation.date
                }
            } catch {
                print("Error save the information - \(error)")
            }
        }
        saveContext()
    }

    func update(this name: String) {
        let fetchRequest: NSFetchRequest<UpdateInformationDM> = UpdateInformationDM.fetchRequest()
        let informationPredicate = NSPredicate(format: "name == %@", name as String)
        fetchRequest.predicate = informationPredicate
        do {
            let results = try self.managedContext.fetch(fetchRequest)
            if let result = results.first {
                result.date = "\(Constants.nextUpdate)"
            }
        } catch {
            print("Error createOrUpdate the products - \(error)")
        }
        saveContext()
    }

    func deleteInformation() {
        let fetchRequest: NSFetchRequest<UpdateInformationDM> = UpdateInformationDM.fetchRequest()
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

        do {
            try managedContext.execute(deleteBatch)
            print("Success deleting information")
        } catch {
            print("Error deleting information \(error)")
        }
    }
}
