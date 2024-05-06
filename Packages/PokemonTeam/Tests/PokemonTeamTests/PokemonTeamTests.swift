import XCTest
import CoreData
@testable import PokemonTeam

class CoreDataPokemonStoreTests: XCTestCase {
    var store: CoreDataPokemonStore!
    var container: NSPersistentContainer!
    
    override func setUpWithError() throws {
        // Initialize the in-memory container
        container = NSPersistentContainer.inMemoryContainer(name: "Pokemon")
        store = CoreDataPokemonStore(container: container)
    }
    
    override func tearDownWithError() throws {
        store = nil
        container = nil
    }
    
    func testInsertPokemon() async throws {
        let pokemon = PokemonModel(front: "frontData".data(using: .utf8), id: 1, name: "TestPokemon", types: ["Fire", "Flying"])
        
        try await store.insert(pokemon: pokemon)
        
        // Fetch to verify insertion
        let fetchedPokemons = try await store.retrieve()
        
        XCTAssertEqual(fetchedPokemons.count, 1)
        XCTAssertEqual(fetchedPokemons.first?.name, "TestPokemon")
    }
    
    func testDeletePokemon() async throws {
        // Insert a Pokemon
        let pokemon = PokemonModel(front: "frontData".data(using: .utf8), id: 1, name: "TestPokemon", types: ["Fire", "Flying"])
        try await store.insert(pokemon: pokemon)
        
        // Delete the Pokemon
        try await store.delete(id: 1)
        
        // Fetch to verify deletion
        let fetchedPokemons = try await store.retrieve()
        
        XCTAssertTrue(fetchedPokemons.isEmpty)
    }
}

extension NSPersistentContainer {
    static func inMemoryContainer(name: String) -> NSPersistentContainer {
        let modelURL = Bundle.module.url(forResource: name, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        let container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null") // In-memory store
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }
}
