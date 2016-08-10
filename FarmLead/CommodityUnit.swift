//
//  CommodityUnit.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import Foundation
import ObjectMapper

class CommodityUnit: NSObject, Mappable {
    
    //MARK: Properties
    var id: Int?
    var name: String?
    var nameRaw: String?
    var commodityUnitDefault: Int?
    var nameShort: String?
    var order: Int?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        id                              <- map["id"]
        commodityUnitDefault            <- map["default"]
        order                           <- map["order"]
        name                            <- map["name"]
        nameRaw                         <- map["name_raw"]
        nameShort                       <- map["name_short"]
    }
}