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
}

final class PokemonListRepositoryImplementation: PokemonListRepository {
    //MARK: - Private properties
    private var requester: Requester
    
    //MARK: - Initialization
    init(requester: Requester = DefaultRequester()) {
        self.requester = requester
    }
    
    //MARK: - Open methods
    
    func getGenerations() async throws -> PokemonGenerationModel {
        let response = try await requester.request(basedOn: GenerationRequestInfos.getGenerations)
        return try await parseResponse(response: response)
    }
    
    // MARK: - Private methods
    private func parseResponse(response: RequestSuccessResponse) async throws -> PokemonGenerationModel {
        do {
            let model = try JSONDecoder().decode(PokemonGenerationModel.self, from: response.data)
            return model
        } catch {
            throw error
        }
    }
}
