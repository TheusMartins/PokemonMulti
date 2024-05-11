//
//  RemoteImage.swift
//
//
//  Created by Scizor on 5/10/24.
//

import Foundation
import UIKit

public extension UIImage {
    static func load(from: URL) async -> UIImage {
        let requester = DownloadImageServiceImplementation()
        
        do {
            let data = try await requester.getPokemon(url: from)
            guard let image = UIImage.init(data: data) else {
                return UIImage(named: "notFoundImage") ?? UIImage()
            }
            return image
        } catch {
            return UIImage(named: "notFoundImage") ?? UIImage()
        }
    }
    
    static func load(from: String) async -> UIImage {
        let requester = DownloadImageServiceImplementation()
        do {
            let data = try await requester.getPokemon(pokemonId: from)
            guard let image = UIImage.init(data: data) else {
                return UIImage(named: "notFoundImage") ?? UIImage()
            }
            return image
        } catch {
            return UIImage(named: "notFoundImage") ?? UIImage()
        }
    }
}
