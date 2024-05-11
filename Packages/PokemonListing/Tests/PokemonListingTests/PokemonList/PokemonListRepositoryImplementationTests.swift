//
//  PokemonListRepositoryImplementationTests.swift
//  
//
//  Created by Scizor on 5/9/24.
//

import XCTest
import Network
@testable import PokemonListing

class PokemonListRepositoryImplementationTests: XCTestCase {
    var requesterSpy: RequesterSpy!
    var sut: PokemonListRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        requesterSpy = RequesterSpy()
        sut = PokemonListRepositoryImplementation(requester: requesterSpy)
    }
    
    override func tearDown() {
        requesterSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetGenerationsSuccess() async throws {
        let sampleData = """
            {
            "results": [
                {"url": "https://anyurl.com", "name": "generation1"},
                {"url": "https://anyurl.com", "name": "generation2"},
                {"url": "https://anyurl.com", "name": "generation3"}
            ]
            }
        """.data(using: .utf8)!
        requesterSpy.nextResponse = RequestSuccessResponse(data: sampleData, response: .init())
        requesterSpy.shouldThrowError = false
        
        do {
            let generations = try await sut.getGenerations()
            XCTAssertEqual(requesterSpy.requestCallCount, 1)
            XCTAssertEqual(generations.results.count, 3)
        } catch {
            XCTFail("Expected success but received error: \(error)")
        }
    }
    
    func testGetGenerationsFailure() async throws {
        requesterSpy.shouldThrowError = true
        
        do {
            _ = try await sut.getGenerations()
            XCTFail("Expected failure but succeeded")
        } catch {
            XCTAssertEqual(requesterSpy.requestCallCount, 1)
        }
    }
    
    func testGetPokemonsSuccess() async throws {
        let sampleData = """
            {
            "pokemon_species": [
                {"url": "https://anyurl.com", "name": "Bulbasaur"},
                {"url": "https://anyurl.com", "name": "Ivysaur"},
                {"url": "https://anyurl.com", "name": "Venusaur"}
            ]
            }
        """.data(using: .utf8)!
        requesterSpy.nextResponse = RequestSuccessResponse(data: sampleData, response: .init())
        requesterSpy.shouldThrowError = false
        
        do {
            let pokemons = try await sut.getPokemons(generationId: 1)
            XCTAssertEqual(requesterSpy.requestCallCount, 1)
            XCTAssertEqual(pokemons.results.count, 3)
        } catch {
            XCTFail("Expected success but received error: \(error)")
        }
    }
    
    func testGetPokemonsFailure() async throws {
        requesterSpy.shouldThrowError = true
        
        do {
            _ = try await sut.getPokemons(generationId: 1)
            XCTFail("Expected failure but succeeded")
        } catch {
            XCTAssertEqual(requesterSpy.requestCallCount, 1)
        }
    }
}
