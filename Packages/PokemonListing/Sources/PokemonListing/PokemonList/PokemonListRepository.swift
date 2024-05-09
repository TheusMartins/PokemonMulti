//
//  PokemonListRepository.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Foundation
import Network

protocol PokemonListRepository {
    func getGenerations() async throws -> PokemonGenerationModel
    func getPokemons(generationId: Int) async throws -> PokemonListModel
}

final class PokemonListRepositoryImplementation: PokemonListRepository {
    // MARK: - Private properties
    
    private var requester: Requester
    
    // MARK: - Initialization
    
    init(requester: Requester = DefaultRequester()) {
        self.requester = requester
    }
    
    // MARK: - Open methods
    
    func getGenerations() async throws -> PokemonGenerationModel {
        let response = try await requester.request(basedOn: GenerationRequestInfos.getGenerations)
        return try await parseGenerationResponse(response: response)
    }
    
    func getPokemons(generationId: Int) async throws -> PokemonListModel {
        let response = try await requester.request(basedOn: PokemonRequest.getPokemons(generationId: generationId))
        return try await parsePokemonResponse(response: response)
    }
    
    // MARK: - Private methods
    
    private func parseGenerationResponse(response: RequestSuccessResponse) async throws -> PokemonGenerationModel {
        do {
            let model = try JSONDecoder().decode(PokemonGenerationModel.self, from: response.data)
            return model
        } catch {
            throw error
        }
    }
    
    private func parsePokemonResponse(response: RequestSuccessResponse) async throws -> PokemonListModel {
        do {
            let model = try JSONDecoder().decode(PokemonListModel.self, from: response.data)
            return model
        } catch {
            throw error
        }
    }
}
