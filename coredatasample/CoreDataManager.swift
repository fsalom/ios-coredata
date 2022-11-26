import CoreData

class CoreDataManager {
    // MARK: Propierties
    private let modelName: String

    lazy var managedContext: NSManagedObjectContext = self.persistentContainer.viewContext

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        let description = NSPersistentStoreDescription()

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

    // MARK: Functions
    func deleteDB() {

    }

    func saveContext(saveDate: Bool = false) {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
            if saveDate {
                //Cache.set(.dateOfUpdate, Date())
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
