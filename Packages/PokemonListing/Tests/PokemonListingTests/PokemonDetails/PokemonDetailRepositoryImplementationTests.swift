//
//  PokemonDetailRepositoryImplementationTests.swift
//
//
//  Created by Scizor on 5/9/24.
//

import XCTest
import Network
@testable import PokemonListing

final class PokemonDetailRepositoryImplementationTests: XCTestCase {
    private var requesterSpy: RequesterSpy!
    private var repository: PokemonDetailRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        requesterSpy = RequesterSpy()
        repository = PokemonDetailRepositoryImplementation(requester: requesterSpy)
    }
    
    override func tearDown() {
        requesterSpy = nil
        repository = nil
        super.tearDown()
    }
    
    func testGetPokemonSuccess() async throws {
        // Given
        let samplePokemonData = """
        {
          "id": 25,
          "name": "Pikachu",
          "sprites": {
            "front_default": "https://example.com/pikachu_front.png"
          },
          "types": [
            {
              "type": {
                "name": "Electric"
              }
            }
          ]
        }
        """.data(using: .utf8)!
        let response = RequestSuccessResponse(data: samplePokemonData, response: URLResponse())
        requesterSpy.nextResponse = response
        
        // When
        do {
            let pokemonDetails = try await repository.getPokemon(pokemonName: "Pikachu")
            
            // Then
            XCTAssertEqual(requesterSpy.requestCallCount, 1)
            XCTAssertEqual(pokemonDetails.name, "Pikachu")
            XCTAssertEqual(pokemonDetails.id, 25)
            XCTAssertEqual(pokemonDetails.types[0].type.name, "Electric")
        } catch {
            XCTFail("Expected successful fetch, but got error: \(error)")
        }
    }
    
    func testGetPokemonFailure() async throws {
        // Given
        requesterSpy.shouldThrowError = true
        
        // When
        do {
            _ = try await repository.getPokemon(pokemonName: "Pikachu")
            XCTFail("Expected failure, but succeeded")
        } catch {
            // Then
            XCTAssertEqual(requesterSpy.requestCallCount, 1)
        }
    }
    
    func testGetPokemonFailureCouldNotParse() async throws {
        // Given
        let samplePokemonData = """
        {
          "id": 25,
          "name": "Pikachu",
          "types": [
            {
              "type": {
                "name": "Electric"
              }
            }
          ]
        }
        """.data(using: .utf8)!
        let response = RequestSuccessResponse(data: samplePokemonData, response: URLResponse())
        requesterSpy.nextResponse = response
        
        // When
        do {
            let pokemonDetails = try await repository.getPokemon(pokemonName: "Pikachu")
            XCTFail("Expected error fetch, but got: \(pokemonDetails)")
        } catch {
            XCTAssertEqual(requesterSpy.requestCallCount, 1)
        }
    }
}
