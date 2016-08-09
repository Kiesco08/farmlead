//
//  PersonalizationTableViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import UIKit

class PersonalizationTableViewController: UITableViewController {
    
    //MARK: Constants
    let sectionNames = [NSLocalizedString("Where are you located?", comment: ""),
                        NSLocalizedString("Which unit do you prefer to deal with?", comment: "")]
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = NSLocalizedString("Personalize your FarmLead", comment: "")
        
        setupViews()
    }
    
    //MARK: Functions
    func setupViews() {
        configureToolbar()
    }
    
    func configureToolbar() {
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .Plain, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButtonItem(doneButton, animated: false)
    }
    
    func doneAction() {
        let alertController = UIAlertController(title: NSLocalizedString("Done", comment: ""), message: NSLocalizedString("The demo is finished. Hope you enjoyed :)", comment: ""), preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: NSLocalizedString("Got it", comment: ""), style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func calculateHeightForHeaderSection(section: Int) -> UIView {
        
        var text = " "
        if section < sectionNames.count {
            text = sectionNames[section]
        }
        // Create section title
        let lblSectionName = UILabel()
        lblSectionName.text = text
        lblSectionName.textColor = UIColor.lightGrayColor()
        lblSectionName.numberOfLines = 0
        lblSectionName.lineBreakMode = .ByWordWrapping
        lblSectionName.sizeToFit()
        
        // Create section title frame
        var frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, lblSectionName.frame.size.height)
        frame.origin.x = 10
        frame.origin.y = 10
        frame.size.width = self.view.bounds.size.width - frame.origin.x
        lblSectionName.frame = frame
        
        // Embed section title in a view
        frame.origin.x = 0
        frame.origin.y = 0
        let customView = UIView(frame: frame)
        customView.addSubview(lblSectionName)
        customView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        return customView

    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionNames.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return calculateHeightForHeaderSection(section).frame.size.height + 16 // Padding
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return calculateHeightForHeaderSection(section)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.section {
            
            case 0: // LOCATION
                break
                
            case 1: // COMMODITY
                break
            
            default:
                break
            
        }
    }

}
