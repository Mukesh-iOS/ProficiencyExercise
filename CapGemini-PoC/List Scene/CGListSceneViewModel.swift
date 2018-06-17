//
//  CGListSceneViewModel.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

class CGListSceneViewModel: NSObject {
    
    func listAPICall(_ completion: @escaping (String?) -> ())
    {
        CGWebServiceRequest.serviceRequest(urlRequest: CGListSceneModel.listRequest(), resultStruct: CGListSceneModel.self) { (listResponse, errorInfo) in
            
            if errorInfo == nil {
                
                debugPrint(listResponse as! NSDictionary)
            }
            completion(errorInfo)
        }
    }
}

