//
//  PokemonModel.swift
//
//
//  Created by Scizor on 5/3/24.
//

import Foundation

public struct PokemonModel: Equatable {
    let front: Data?
    let id: Int
    let name: String?
    let types: [String]?
    
    public init(front: Data?, id: Int, name: String?, types: [String]?) {
        self.front = front
        self.id = id
        self.name = name
        self.types = types
    }
}
