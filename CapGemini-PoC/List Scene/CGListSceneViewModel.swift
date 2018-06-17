//
//  CGListSceneViewModel.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

class CGListSceneViewModel: NSObject {
    
    var screenTitle : String?
    var lists : [rowDetails]?
    
    func listAPICall(_ completion: @escaping (String?) -> ())
    {
        CGWebServiceRequest.serviceRequest(urlRequest: CGListSceneModel.listRequest(), resultStruct: CGListSceneModel.self) { [weak self] (listResponse, errorInfo) in
            
            if errorInfo == nil, let strongSelf = self {
                
                strongSelf.screenTitle = (listResponse as? CGListSceneModel)?.title
                
                // Eliminate data if image, title and description are null and grouping into array
                strongSelf.lists = (listResponse as? CGListSceneModel)?.rows?.filter ({
                    $0.title != nil || $0.description != nil || $0.imageHref != nil
                })
                
                // Clearing cache which will help in replacing images if it is changed on remote
                
                cachedIndexPaths.removeAll()
                imageCache.removeAllObjects()
            }
            completion(errorInfo)
        }
    }
}

