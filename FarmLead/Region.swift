//
//  Region.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-16.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import Foundation
import ObjectMapper

class Region: NSObject, Mappable {
    
    //MARK: Properties
    var provinceId: Int?
    var cityId: Int?
    var provinceName: String?
    var cityName: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        provinceId              <- map["province_id"]
        cityId                  <- map["city_id"]
        provinceName            <- map["province_name"]
        cityName                <- map["city_name"]
    }
}