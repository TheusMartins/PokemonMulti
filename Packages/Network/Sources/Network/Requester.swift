//
//  Requester.swift
//  
//
//  Created by Scizor on 4/26/24.
//

import Foundation

public protocol Requester {
    func request(based on: RequestInfos) async -> Result<RequestSuccessResponse, RequestError>
}

public final class DefaultRequester: Requester {
    public func request(based on: RequestInfos) async -> Result<RequestSuccessResponse, RequestError> {
        return .failure(.invalidResponse)
    }
}
