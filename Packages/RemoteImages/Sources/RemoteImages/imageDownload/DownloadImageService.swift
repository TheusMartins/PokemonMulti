//
//  DownloadImageService.swift
//
//
//  Created by Scizor on 5/10/24.
//

import Foundation
import Network

public protocol DownloadImageService {
    func getPokemon(url: URL) async throws -> Data
    func getPokemon(pokemonId: Int) async throws -> Data
}

public final class DownloadImageServiceImplementation: DownloadImageService {
    // MARK: - Private properties
    
    private var requester: Requester
    
    // MARK: - Initialization
    
    init(requester: Requester = DefaultRequester()) {
        self.requester = requester
    }
    
    // MARK: - Public methods
    
    public func getPokemon(url: URL) async throws -> Data {
        do {
            return try await requester.request(basedOn: ImageDownlaodRequest.getPokemonWithURL(url)).data
        } catch {
            throw error
        }
    }
    
    public func getPokemon(pokemonId: Int) async throws -> Data {
        do {
            return try await requester.request(basedOn: ImageDownlaodRequest.getPokemonWithId(pokemonId)).data
        } catch {
            throw error
        }
    }
}
