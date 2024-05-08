//
//  Requester.swift
//  
//
//  Created by Scizor on 4/26/24.
//

import Foundation

public protocol Requester {
    func request(basedOn infos: RequestInfos) async throws -> RequestSuccessResponse
}

public final class DefaultRequester: Requester {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request(basedOn infos: RequestInfos) async throws -> RequestSuccessResponse {
        guard let request = buildURLRequest(basedOn: infos) else {
            throw RequestError.invalidURL
        }
        do {
            let (data, response) = try await session.data(for: request)
            return .init(data: data, response: response)
        } catch {
            throw RequestError.invalidResponse
        }
    }
    
    // MARK: Helpers
    
    private func buildURLRequest(basedOn infos: RequestInfos) -> URLRequest? {
        guard let baseURL = infos.baseURL, var url = URLComponents(string: "\(baseURL)\(infos.endpoint)") else {
            return nil
        }
        
        var components: [URLQueryItem] = []
        
        infos.parameters?.forEach({ key, value in
            components.append(URLQueryItem(name: key, value: "\(value)"))
        })
        
        url.queryItems = components
        
        guard let finalURL = url.url else {
            return nil
        }
        
        return URLRequest(url: finalURL)
    }
}
