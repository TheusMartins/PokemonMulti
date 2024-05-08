//
//  GenerationRequestInfos.swift
//
//
//  Created by Scizor on 5/8/24.
//

import Network

enum GenerationRequestInfos {
    case getGenerations
}

extension GenerationRequestInfos: RequestInfos {
    var endpoint: String {
        .endpoint
    }
    
    var method: Network.HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        nil
    }
}

private extension String {
    static var endpoint: String {
        "generation"
    }
}
