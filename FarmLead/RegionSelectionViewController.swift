//
//  RegionSelectionViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-16.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
// This class allows the user to select a region

import UIKit
import Alamofire

class RegionSelectionViewController: UIViewController {
    //MARK: UI Connections
    @IBOutlet weak var regionTextField: AutoCompleteTextField!
    
    //MARK: Variables
    var searchRequest: Alamofire.Request?
    var regions = [Region]()
    var cityLabel: UILabel?
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Choose a city", comment: "")
        
        setupViews()
    }
    
    //MARK: Functions
    func setupViews() {
        customizeRegionTextField()
        handleRegionTextFieldInterfaces()
    }
    
    func customizeRegionTextField() {
        // Keyboard toolbar
        let emailKeyboardToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, SCREEN_WIDTH, 40))
        emailKeyboardToolbar.barStyle = UIBarStyle.Default
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: UIBarButtonItemStyle.Done, target: self, action: #selector(dismissKeyboard))
        emailKeyboardToolbar.setItems([space, done], animated: false)
        emailKeyboardToolbar.sizeToFit()

        self.regionTextField.inputAccessoryView = emailKeyboardToolbar
    }
    
    func handleRegionTextFieldInterfaces() {
        regionTextField.onTextChange = {[weak self] text in
            if !text.isEmpty && text.characters.count > 1 {
                if let searchRequest = self?.searchRequest {
                    searchRequest.cancel()
                }
                let triggerTime = (Int64(NSEC_PER_SEC) * SEARCH_DELAY)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    fetchRegions(text, completion: { regions in
                        guard let regions = regions else {
                            return
                        }
                        
                        self?.regions = regions

                        var autoCompleteStrings = [String]()
                        for region in regions {
                            var cityName = NSLocalizedString("Unknown", comment: "")
                            var provinceName = NSLocalizedString("Unknown", comment: "")
                            if let actualCityName = region.cityName {
                                cityName = actualCityName
                            }
                            if let actualProvinceName = region.provinceName {
                                provinceName = actualProvinceName
                            }
                            autoCompleteStrings.append("\(cityName), \(provinceName)")
                        }
                        self?.regionTextField.autoCompleteStrings = autoCompleteStrings
                    })
                })
            }
        }

        regionTextField.onSelect = {[weak self] text, indexpath in
            if let regionSelected = self?.regions[indexpath.row],
                let cityId = regionSelected.cityId {
                
                saveIntToUserDefaults(SELECTED_CITY_KEY, object: cityId)
                
                // Update city label
                self?.cityLabel?.text = regionSelected.cityName
                self?.cityLabel?.textColor = UIColor.blackColor()
            }
            self?.navigationController?.popViewControllerAnimated(true)
        }
    }

}
