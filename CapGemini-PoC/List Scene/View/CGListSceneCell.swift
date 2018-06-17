//
//  CGListSceneCell.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

class CGListSceneCell : UITableViewCell {
    
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var contentPic: UIImageView!
    @IBOutlet weak var contentDescription: UILabel!
    
    func loadData(model: [rowDetails], onIndex : IndexPath) {
        
        topic.text = (model[onIndex.row] as rowDetails).title
        contentPic.image = UIImage.init(named: "PlaceHolder")
        
        let descriptionText = (model[onIndex.row] as rowDetails).description
        contentDescription.text = descriptionText ?? "No description available"
        contentDescription.textColor = descriptionText != nil ? UIColor.darkGray : UIColor.lightGray
    }
}

