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

extension String
{
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}
