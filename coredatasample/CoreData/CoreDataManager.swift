import CoreData

class CoreDataManager {
    // MARK: Propierties
    private let modelName: String

    lazy var managedContext: NSManagedObjectContext = self.persistentContainer.viewContext

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)

        let storeURL = try! FileManager
                .default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("\(modelName).sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)

        description.type = NSSQLiteStoreType
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print(error)
            }
        }

        return container
    }()

    // MARK: Init
    init(modelName: String) {
        self.modelName = modelName
    }

    func saveContext(saveDate: Bool = false) {
        do {
            try managedContext.save()
            print("SAVED")
            if saveDate {
                //Cache.set(.dateOfUpdate, Date())
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
