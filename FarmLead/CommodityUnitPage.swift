//
//  CommodityUnitPage.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import Foundation
import ObjectMapper

class CommodityUnitPage: NSObject, Mappable {
    
    //MARK: Properties
    var commodityUnits: [CommodityUnit]?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        commodityUnits                       <- map["data.commodityUnit"]
    }
}