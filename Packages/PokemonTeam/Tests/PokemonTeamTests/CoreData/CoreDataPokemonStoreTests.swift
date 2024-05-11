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
    
    func test_retrieve_noItems() async throws {
        // Given + When
        let fetchedPokemons = try await store.retrieve()
        
        // Then
        XCTAssertTrue(fetchedPokemons.isEmpty)
    }
    
    func test_retrieve_withItems() async throws {
        // Given
        let pokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        
        try await store.insert(pokemon: pokemon)
        
        // When
        let fetchedPokemons = try await store.retrieve()
        
        // Then
        XCTAssertTrue(!fetchedPokemons.isEmpty)
    }
    
    func test_insert_pokemonSuccessfully() async throws {
        // Given
        let pokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        
        try await store.insert(pokemon: pokemon)
        
        // When
        let fetchedPokemons = try await store.retrieve()
        
        // Then
        XCTAssertEqual(fetchedPokemons.count, 1)
    }
    
    func test_delete_pokemonSuccessfully() async throws {
        // Given
        let pokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        try await store.insert(pokemon: pokemon)
        
        // When
        try await store.delete(id: 6)
        
        let fetchedPokemons = try await store.retrieve()
        
        // Then
        XCTAssertTrue(fetchedPokemons.isEmpty)
    }
    
    func test_notDelete_whenIdIsWrong() async throws {
        // Given
        let pokemon = PokemonTeam.PokemonModel(front: "frontData".data(using: .utf8), id: 6, name: "Charizard", types: ["Fire", "Flying"])
        try await store.insert(pokemon: pokemon)
        
        // When
        try await store.delete(id: 1)
        
        let fetchedPokemons = try await store.retrieve()
        
        // Then
        XCTAssertTrue(!fetchedPokemons.isEmpty)
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
        return container
    }
}
