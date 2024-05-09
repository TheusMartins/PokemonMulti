//
//  PokemonDetailRepository.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Network
import Foundation

protocol PokemonDetailRepository {
    func getPokemon(pokemonName: String) async throws -> PokemonDetailsModel
}

final class PokemonDetailRepositoryImplementation: PokemonDetailRepository {
    
    // MARK: - Private properties
    
    private var requester: Requester
    
    // MARK: - Initialization
    
    init(requester: Requester = DefaultRequester()) {
        self.requester = requester
    }
    
    // MARK: - Open methods
    
    func getPokemon(pokemonName: String) async throws -> PokemonDetailsModel {
        let response = try await requester.request(basedOn: PokemonDetailRequest.getPokemonDetails(pokemonName: pokemonName))
        return try await parsePokemonDetailResponse(response: response)
    }
    
    // MARK: - Private methods
    
    private func parsePokemonDetailResponse(response: RequestSuccessResponse) async throws -> PokemonDetailsModel {
        do {
            let model = try JSONDecoder().decode(PokemonDetailsModel.self, from: response.data)
            return model
        } catch {
            throw error
        }
    }
}
