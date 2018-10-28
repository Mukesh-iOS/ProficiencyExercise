//
//  CGListSceneCell.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

class CGListSceneCell: UITableViewCell {
    
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var contentPic: UIImageView!
    @IBOutlet weak var contentDescription: UILabel!
    
    func loadData(model: [rowDetails]?, onIndex: IndexPath) {
        
        topic.text = model?[onIndex.row].title
        contentPic.image = UIImage.init(named: "PlaceHolder")
        
        let descriptionText = model?[onIndex.row].description
        contentDescription.text = descriptionText ?? "No description available"
        contentDescription.textColor = descriptionText != nil ? UIColor.darkGray : UIColor.lightGray
        
        if let urlString = model?[onIndex.row].imageHref {
            
            // Download images on background
            DispatchQueue.global(qos: .background).async {
                
                UIImageView.downloadImageFrom(link: urlString, withIndexPath: onIndex) { (downloadedImage) in
                    
                    DispatchQueue.main.async {
                        
                        // Updating UI on main thread
                        self.contentPic.image = downloadedImage
                    }
                }
            }
        }
    }
}

