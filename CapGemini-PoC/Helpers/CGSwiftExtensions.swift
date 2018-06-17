//
//  CGSwiftExtensions.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

extension URLRequest {
    
    static func getRequestWithConfiguration(_ urlString: String?) -> URLRequest? {
        guard var urlRequest = urlRequestWithConfig(urlString) else {
            return nil
        }
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
    
    private static func urlRequestWithConfig(_ urlString: String?) -> URLRequest? {
        
        guard let givenURLString = urlString, let urlComponent = URLComponents.init(string: givenURLString), let url = urlComponent.url else {
            return nil
        }
        
        return URLRequest.init(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
    }
}
