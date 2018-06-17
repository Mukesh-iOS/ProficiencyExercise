//
//  CGListSceneVC.swift
//  CapGemini-PoC
//
//  Created by murugananda on 17/06/18.
//  Copyright © 2018 murugananda. All rights reserved.
//

import UIKit

class CGListSceneVC: UIViewController{
    
    @IBOutlet weak var listTable: UITableView!
    
    var lists : [rowDetails]?
    let listViewModel = CGListSceneViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: Initial Setup
    
    func initialSetup()
    {
        // Getting list details
        getListsFromRest()
        
        // Navigation bar setup
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
    }
    
    func getListsFromRest()
    {
        listViewModel.listAPICall { [weak self] (errorInfo) in
        
            if let strongSelf = self
            {
                DispatchQueue.main.async {
                    
                    /* Updating UI on success */
                    
                    // Set navigation title
                    strongSelf.navigationItem.title = strongSelf.listViewModel.screenTitle
                    
                    // Reload tableview
                    strongSelf.lists = strongSelf.listViewModel.lists
                    strongSelf.listTable.reloadData()
                    
                    debugPrint(errorInfo ?? "No error")
                }
            }
        }
    }
    
    @IBAction func popScreen(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CGListSceneVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CGListSceneCell") as! CGListSceneCell
        
        cell.loadData(model: self.lists!, onIndex: indexPath)
        
        return cell
    }
    
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.lists?.count ?? 0
    }
}
