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
    var imageWithWidthPaddings : CGFloat?
    var imageWithHeightPaddings : CGFloat?
    
    var refreshControl = UIRefreshControl()
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
        
        // Adding pull to refresh logic
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshScreen), for: .valueChanged)
        listTable.addSubview(refreshControl)
        
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
                    
                    // Remove refresh control
                    if(strongSelf.refreshControl.isRefreshing) {
                        
                        strongSelf.refreshControl.endRefreshing()
                    }
                    
                    if let errorDescription = errorInfo {
                        
                        // Show alert on error cases
                        UIAlertController().showSimpleAlert(message: errorDescription, inViewController: strongSelf)
                        return
                    }
                    
                    // Set navigation title
                    strongSelf.navigationItem.title = strongSelf.listViewModel.screenTitle
                    
                    // Reload tableview
                    strongSelf.lists = strongSelf.listViewModel.lists
                    strongSelf.listTable.reloadData()
                }
            }
        }
    }
    
    @IBAction func popScreen(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: Helper Methods
    
    @objc func refreshScreen() {
        
        getListsFromRest()
    }
    
    func calculateConstants()
    {
        // Calculation changes depends on device and orientation
        
        let imageWidthAndHeight : CGFloat = listTable.frame.size.width - ((listTable.frame.size.width / 3) * 2)
        imageWithWidthPaddings = imageWidthAndHeight + CGFloat(constraintsConstants.widthPaddings)
        imageWithHeightPaddings = imageWidthAndHeight + CGFloat(constraintsConstants.heightPaddings)
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
        
        calculateConstants()
        
        let contentLabelWidth = tableView.frame.size.width - imageWithWidthPaddings!
        
        let cellDetail : rowDetails = self.lists![indexPath.row]
        
        if let contentDescription = cellDetail.description{
            let ContentHeight = contentDescription.height(withConstrainedWidth: contentLabelWidth, font: UIFont.preferredFont(forTextStyle: .body))
            
            // Calculating total height of the cell dynamically adding with paddings
            
            let cellHeight = (ContentHeight + CGFloat(constraintsConstants.heightPaddings)) < imageWithHeightPaddings! ? imageWithHeightPaddings! : ContentHeight + CGFloat(constraintsConstants.heightPaddings)
            
            return cellHeight
        }
        return imageWithHeightPaddings!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.lists?.count ?? 0
    }
}
