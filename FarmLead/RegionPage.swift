//
//  RegionPage.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-16.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import Foundation
import ObjectMapper

class RegionPage: NSObject, Mappable {
    
    //MARK: Properties
    var result: Bool?
    var count: Int?
    var regions: [Region]?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        result                        <- map["result"]
        count                         <- map["count"]
        regions                       <- map["regions"]
    }
}