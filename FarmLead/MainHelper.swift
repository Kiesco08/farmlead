//
//  MainHelper.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
//  This file contains functions used across the whole app

import Foundation
import SwiftyJSON
import ObjectMapper

//MARK: Constants. TODO: Move to .plist file
let FARM_LEAD_GREEN = "4d9e6e"
let storyboardTotalPages = 3
let COMMODITY_UNIT_END_POINT = "http://dualstack.FL2-Dev-api02-1164870265.us-east-1.elb.amazonaws.com/api/v2/data"
let REGION_SEARCH_END_POINT = "http://dualstack.FL2-Dev-api02-1164870265.us-east-1.elb.amazonaws.com/api/v2/search_region"
let COMMODITY_UNIT_KEY = "commodityUnit"
let SELECTED_COMMODITY_UNIT_KEY = "selectedCommodityUnit"
let SEARCH_DELAY: Int64 = 3 / 10

//MARK: Utility Constants
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

//MARK: Functions
func fetchAndCacheInitialData() {
    fetchAndCacheCommodityUnits()
}

func fetchAndCacheCommodityUnits() {
    // Get current date
    let formatter = NSDateFormatter()
    formatter.dateFormat = apiDateFormat
    let currentDate = "2013-04-25 18:03:12" // Hardcoded for demo
    
    // Build POST body
    var body = [String: AnyObject]()
    var data = [String: AnyObject]()
    
    data[COMMODITY_UNIT_KEY] = currentDate
    body["data"] = data
    
    callRestApi(COMMODITY_UNIT_END_POINT, method: .POST, withBody: body) { (statusCode, json, error) in
        guard let commodityUnits = json else {
            if let error = error {
                print("\(error)")
            }
            return
        }
        
        // Cache commodity units
        saveStringToUserDefaults(COMMODITY_UNIT_KEY, object: String(commodityUnits))
    }
}

func getCommodityUnits() -> [CommodityUnit]? {
    guard let jsonString = getStringFromUserDefaults(COMMODITY_UNIT_KEY)
        else {
            return nil
    }
    
    print(jsonString)
    
    let commodityUnits = Mapper<CommodityUnitPage>().map(jsonString)
    
    return commodityUnits?.commodityUnits

}

func fetchRegions(search: String) {
    
    // Build POST body
    var body = [String: AnyObject]()
    
    body["search"] = search
    
    callRestApi(REGION_SEARCH_END_POINT, method: .POST, withBody: body) { (statusCode, json, error) in
        guard let regions = json else {
            if let error = error {
                print("\(error)")
            }
            return
        }
        
        print(regions)
    }
}

func saveCommodityId(id: Int) {
    print("Saving commodity with id \(id)")
    saveIntToUserDefaults(SELECTED_COMMODITY_UNIT_KEY, object: id)
}

//MARK: Utilities
func colorWithHexString (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substringFromIndex(1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.grayColor()
    }
    
    let rString = (cString as NSString).substringToIndex(2)
    let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
    let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner(string: rString).scanHexInt(&r)
    NSScanner(string: gString).scanHexInt(&g)
    NSScanner(string: bString).scanHexInt(&b)
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}

func saveStringToUserDefaults(key: String, object: String) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(object, forKey: key)
}

func getStringFromUserDefaults(key: String) -> String? {
    let defaults = NSUserDefaults.standardUserDefaults()
    return defaults.stringForKey(key)
}

func saveIntToUserDefaults(key: String, object: Int) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(object, forKey: key)
}

func getIntFromUserDefaults(key: String) -> Int? {
    let defaults = NSUserDefaults.standardUserDefaults()
    return defaults.integerForKey(key)
}


