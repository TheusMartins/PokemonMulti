//
//  ImageDownloadRepository.swift
//
//
//  Created by Scizor on 5/10/24.
//

import Foundation
import Network

protocol DownloadImageService {
    func getPokemon(url: URL) async throws -> Data
    func getPokemon(pokemonId: String) async throws -> Data
}

final class DownloadImageServiceImplementation: DownloadImageService {
    // MARK: - Private properties
    
    private var requester: Requester
    
    // MARK: - Initialization
    
    init(requester: Requester = DefaultRequester()) {
        self.requester = requester
    }
    
    // MARK: - Public methods
    
    func getPokemon(url: URL) async throws -> Data {
        do {
            return try await requester.request(basedOn: ImageDownlaodRequest.getPokemonWithURL(url)).data
        } catch {
            throw error
        }
        
    }
    
    func getPokemon(pokemonId: String) async throws -> Data {
        do {
            return try await requester.request(basedOn: ImageDownlaodRequest.getPokemonWithId(pokemonId)).data
        } catch {
            throw error
        }
    }
}
