//
//  CGListSceneVC.swift
//  CapGemini-PoC
//
//  Created by Ratheesh on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

class CGListSceneVC: UIViewController{
    
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: Initial Setup
    
    func initialSetup()
    {
        // Navigation bar setup
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
    }
    
    @IBAction func popScreen(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

