//
//  RemoteImage.swift
//
//
//  Created by Scizor on 5/10/24.
//

#if canImport(UIKit)
import Foundation
import UIKit
import DesignSystem

public final class RemoteImageView: UIImageView {
    public var url: URL? {
        didSet {
            guard let url else { return }
            self.hideLoading()
            Task { @MainActor in
                await loadFrom(url: url)
            }
        }
    }
    
    public var pokemonId: String? {
        didSet {
            guard let id = Int(pokemonId ?? "") else { return }
            self.hideLoading()
            Task { @MainActor in
                await loadFrom(pokemonId: id)
            }
        }
    }
    
    private func loadFrom(url: URL) async {
        let requester = DownloadImageServiceImplementation()
        
        do {
            let data = try await requester.getPokemon(url: url)
            guard let image = UIImage(data: data) else {
                image = UIImage(named: "notFoundImage") ?? UIImage()
                return
            }
            self.image = image
        } catch {
            image = UIImage(named: "notFoundImage") ?? UIImage()
        }
    }
    
    private func loadFrom(pokemonId: Int) async {
        let requester = DownloadImageServiceImplementation()
        do {
            let data = try await requester.getPokemon(pokemonId: pokemonId)
            guard let image = UIImage(data: data) else {
                image = UIImage(named: "notFoundImage", in: .module, with: nil) ?? UIImage()
                return
            }
            
            self.image = image
        } catch {
            image = UIImage(named: "notFoundImage") ?? UIImage()
        }
    }
}
#endif
