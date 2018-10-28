//
//  CGListSceneModel.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

struct CGListSceneModel: Codable {
    
    // List Scene API Request Info
    
    private static var listURL: String {
        return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    
    static func listRequest() -> URLRequest{
        
        return URLRequest.getRequestWithConfiguration(listURL)!
    }
    
    // List Scene API response
    
    let title: String?
    let rows: Array<rowDetails>?
}

struct rowDetails: Codable
{
    let title: String?
    let description: String?
    let imageHref: String?
}

