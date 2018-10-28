//
//  CGWebEngine.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import Foundation

import UIKit

struct CGWebServiceRequest {
    
    // Resusable web engine for dynamic models by using generics
    static func serviceRequest<T>(urlRequest: URLRequest?,
                                  resultStruct: T.Type,
                                  completionHandler:@escaping ((Any?, String?) -> Void ))  where T: Decodable  {
        
        // Build URL
        guard let apiURLRequest = urlRequest, let _ = apiURLRequest.url else {
            
            completionHandler(nil, "Could not find URL")
            return
        }
        
        if Reachability().isConnectedToNetwork() {
            
            let queue: OperationQueue = OperationQueue()
            
            NSURLConnection.sendAsynchronousRequest(apiURLRequest, queue: queue, completionHandler:{ (response: URLResponse?, data: Data?, error: Error?) -> Void in
                
                guard error == nil else {
                    
                    completionHandler(nil, error?.localizedDescription)
                    return
                }
                
                // Check if data is available
                
                guard let _ = data, let httpResponse = response as? HTTPURLResponse else {
                    
                    DispatchQueue.main.async {
                        completionHandler(nil, "No data in response")
                    }
                    return
                }
                
                switch (httpResponse.statusCode) {
                    
                    case StatusCode.Success:
                        
                        let decoder = JSONDecoder()
                        
                        // Getting response in ISOLatin type
                        let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                        
                        // Converting to UTF8 data
                        guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                            completionHandler(nil, "could not convert data to UTF-8 format")
                            return
                        }
                        do {
                            // Converting to json dictionary
                            let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                            debugPrint(responseJSONDict as! NSDictionary)
                            
                            // Parsing to custom model
                            let jsonData = try JSONSerialization.data(withJSONObject: responseJSONDict, options: .prettyPrinted)
                            
                            let resultantModel = try decoder.decode(resultStruct, from: jsonData)
                            DispatchQueue.main.async {
                                completionHandler(resultantModel, nil)
                            }
                        } catch let error {
                            DispatchQueue.main.async {
                                completionHandler(nil, error.localizedDescription)
                            }
                        }
                        break
                    default:
                        // Failure case
                        DispatchQueue.main.async {
                            completionHandler(nil, "Unsuccessfull process")
                        }
                        break
                    }
            })
        } else {
            
            completionHandler(nil, "Bad spot!! No network available")
        }
    }
    
    static func imageRequest(with link: String, completion: @escaping ((UIImage?) -> Void )) {
        URLSession.shared.dataTask( with: URL(string: link)!, completionHandler: {
            (data, response, error) -> Void in
            
            // Check if data is available
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if (httpResponse.statusCode == StatusCode.Success) {
                DispatchQueue.main.async {
                    
                    // Check if image is available
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: link as NSString)
                        completion(image)
                    }
                }
            }
        }).resume()
    }
}
