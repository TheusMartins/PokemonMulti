//
//  RequesterSpy.swift
//
//
//  Created by Scizor on 5/9/24.
//

import Network
import Foundation

final class RequesterSpy: Requester {
    private(set) var requestCallCount = 0
    private(set) var lastReceivedRequestInfos: RequestInfos?
    var nextResponse: RequestSuccessResponse = .init(data: Data(), response: .init())
    var nextError: Error = NSError.init(domain: "", code: 0)
    var shouldThrowError: Bool = false
    
    func request(basedOn infos: RequestInfos) async throws -> RequestSuccessResponse {
        requestCallCount += 1
        lastReceivedRequestInfos = infos
        
        if shouldThrowError {
            throw nextError
        }
        
        return nextResponse
    }
}
