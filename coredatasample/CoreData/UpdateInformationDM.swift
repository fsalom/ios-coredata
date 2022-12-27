//
//  UpdateInformationDM.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 28/11/22.
//

import Foundation
import CoreData

extension CoreDataManager {

    func shouldUpdate(this name: String, result: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let fetchRequest: NSFetchRequest<UpdateInformationDM> = UpdateInformationDM.fetchRequest()
            let informationPredicate = NSPredicate(format: "name == %@", name as String)
            fetchRequest.predicate = informationPredicate

            do {
                let results = try self.managedContext.fetch(fetchRequest)
                if let information = results.first {
                    result(self.isExpired(this: information.date ?? "\(Date())"))
                }else{
                    result(true)
                }
            } catch {
                print("Error createOrUpdate the products - \(error)")
                result(true)
            }
        }
    }

    func isExpired(this date: String) -> Bool {
        let expiryDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        return Date() < dateFormatter.date(from: expiryDate)?.addingTimeInterval(60) ?? Date() ? false : true
    }

    func save(this updateInformations: [UpdateInformation]) {
        DispatchQueue.main.async {
            for updateInformation in updateInformations {
                let fetchRequest: NSFetchRequest<UpdateInformationDM> = UpdateInformationDM.fetchRequest()
                let informationPredicate = NSPredicate(format: "name == %@", updateInformation.name as String)
                fetchRequest.predicate = informationPredicate

                do {
                    let results = try self.managedContext.fetch(fetchRequest)
                    if results.count == 0 {
                        let updateInformationDM = UpdateInformationDM(context: self.managedContext)
                        updateInformationDM.name = updateInformation.name
                        updateInformationDM.date = updateInformation.date
                    }
                } catch {
                    print("Error save the information - \(error)")
                }
            }
            self.saveContext()
        }
    }

    func update(this name: String) {
        print("🕓 Update \(name) last time updated")
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
    }

    func deleteInformation() {
        let fetchRequest: NSFetchRequest<UpdateInformationDM> = UpdateInformationDM.fetchRequest()
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

        do {
            try managedContext.execute(deleteBatch)
            print("🗑 Success deleting information")
        } catch {
            print("Error deleting information \(error)")
        }
    }
}
