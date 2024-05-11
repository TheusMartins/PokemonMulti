//
//  RemoteImage.swift
//
//
//  Created by Scizor on 5/10/24.
//

import Foundation
import UIKit

public extension UIImage {
    static func loadFrom(url: URL) async -> UIImage {
        let requester = DownloadImageServiceImplementation()
        
        do {
            let data = try await requester.getPokemon(url: url)
            guard let image = UIImage(data: data) else {
                return UIImage(named: "notFoundImage") ?? UIImage()
            }
            return image
        } catch {
            return UIImage(named: "notFoundImage") ?? UIImage()
        }
    }
    
    static func loadFrom(pokemonId: Int) async -> UIImage {
        let requester = DownloadImageServiceImplementation()
        do {
            let data = try await requester.getPokemon(pokemonId: pokemonId)
            guard let image = UIImage(data: data) else {
                return UIImage(named: "notFoundImage", in: .module, with: nil) ?? UIImage()
            }
            
            return image
        } catch {
            return UIImage(named: "notFoundImage") ?? UIImage()
        }
    }
}
