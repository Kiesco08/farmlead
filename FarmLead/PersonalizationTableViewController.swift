//
//  PersonalizationTableViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
//  This class allows the user to personalize their FarmLead

import UIKit
import Alamofire

class PersonalizationTableViewController: UITableViewController {
    
    //MARK: UI Connections
    @IBOutlet weak var commodityTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    //MARK: Constants
    let sectionNames = [NSLocalizedString("Where are you located?", comment: ""),
                        NSLocalizedString("Which unit do you prefer to deal with?", comment: "")]
    let sectionHeaderPadding: CGFloat = 20
    let commodityUnitPickerView = UIPickerView()
    
    //MARK: Variables
    var commodityUnits: [CommodityUnit]?
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Personalize your FarmLead", comment: "")
        
        // Make back button an arrow only
        let backButton = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationItem.backBarButtonItem = backButton
        
        setupViews()
    }
    
    //MARK: Functions
    func setupViews() {
        configureToolbar()
        customizeCommodityTextField()
    }
    
    func configureToolbar() {
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .Plain, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButtonItem(doneButton, animated: false)
    }
    
    func doneAction() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summaryViewController = mainStoryboard.instantiateViewControllerWithIdentifier("summary") as! SummaryViewController
        if let city = cityLabel.text where cityLabel.textColor == UIColor.blackColor() {
            summaryViewController.city = city
        }
        if let unit = commodityTextField.text {
            summaryViewController.unit = unit
        }
        self.navigationController?.pushViewController(summaryViewController, animated: true)
    }
    
    func customizeCommodityTextField() {
        // Keyboard toolbar
        let emailKeyboardToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, SCREEN_WIDTH, 40))
        emailKeyboardToolbar.barStyle = UIBarStyle.Default
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: UIBarButtonItemStyle.Done, target: self, action: #selector(dismissKeyboard))
        emailKeyboardToolbar.setItems([space, done], animated: false)
        emailKeyboardToolbar.sizeToFit()
        
        self.commodityTextField.inputAccessoryView = emailKeyboardToolbar
        
        setupCommodityPickerView()
    }
    
    func setupCommodityPickerView() {
        commodityUnitPickerView.delegate = self
        self.commodityTextField.inputView = commodityUnitPickerView
        initializeCommodityUnits()
    }
    
    func initializeCommodityUnits() {
        if let commodityUnits = getCommodityUnits() {
            self.commodityUnits = commodityUnits
            commodityUnitPickerView.reloadAllComponents()
            var indexToSelect = 0
            if let selectedCommodityUnitId = getIntFromUserDefaults(SELECTED_COMMODITY_UNIT_KEY) {
                for (index, commodityUnit) in commodityUnits.enumerate() {
                    if commodityUnit.id == selectedCommodityUnitId {
                        indexToSelect = index
                        break
                    }
                }
            } else {
                print("No commodity unit saved")
            }
            setCommodity(commodityUnits, index: indexToSelect)
        }
    }
    
    func setCommodity(commodityUnits: [CommodityUnit], index: Int) {
        print("Setting commodity at index \(index): \(commodityUnits[index].name)")
        commodityTextField.text = commodityUnits[index].name
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
        var frame = CGRectMake(0, 0, SCREEN_WIDTH, lblSectionName.frame.size.height)
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

}

// MARK: - Table view data source
extension PersonalizationTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionNames.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return calculateHeightForHeaderSection(section).frame.size.height + sectionHeaderPadding // Padding
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return calculateHeightForHeaderSection(section)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.section {
            
        case 0: // LOCATION
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let regionSelectionViewController = mainStoryboard.instantiateViewControllerWithIdentifier("RegionSelectionViewController") as! RegionSelectionViewController
            regionSelectionViewController.cityLabel = cityLabel
            self.navigationController?.pushViewController(regionSelectionViewController, animated: true)
            
            
        case 1: // COMMODITY
            break
            
        default:
            break
            
        }
    }
}

extension PersonalizationTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if let commodityUnits = commodityUnits {
            return commodityUnits.count
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return commodityUnits?[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Get level select and update its name on the UI
        guard let selectedCommodityUnit = commodityUnits?[row] else {
            return
        }
        
        commodityTextField.text = selectedCommodityUnit.name
        
        print("****")
        print(selectedCommodityUnit.id)
        print(selectedCommodityUnit.name)
        print("****")
        
        if let selectedCommodityUnitId = selectedCommodityUnit.id {
            saveCommodityId(selectedCommodityUnitId)
        }
    }
}
