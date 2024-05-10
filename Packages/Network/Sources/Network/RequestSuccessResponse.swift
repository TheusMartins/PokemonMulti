//
//  RequestSuccessResponse.swift
//
//
//  Created by Scizor on 4/26/24.
//

import Foundation

public struct RequestSuccessResponse {
    public let data: Data
    public let response: URLResponse
    
    public init(data: Data, response: URLResponse) {
        self.data = data
        self.response = response
    }
}
