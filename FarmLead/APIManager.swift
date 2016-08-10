//
//  APIManager.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
//  This file contains functions that interact with the API

import Foundation
import ObjectMapper
import Alamofire
import ReachabilitySwift
import SwiftyJSON

//MARK: Constants
let noInternetCode = -1009
let apiDateFormat = "yyyy-mm-dd hh:mm:ss"

//MARK: Functions
func callRestApi(endPoint: String, method: Alamofire.Method, withBody body: [String: AnyObject] = [:], completion: (statusCode: Int?, json: JSON?, error: String?) -> Void) {
    
    // Make sure there is internet connection
    let connectedToInternet = checkInternetConnectivity()
    if connectedToInternet {
        
        print(endPoint)
        print("** body **")
        print(body)
        
        Alamofire.request(method,
            endPoint,
            parameters: body,
            encoding: .JSON)
            .responseJSON { response in
                
                // Handle results on the model side
                handleAPIResultsFromTheModelSide(response.result.isSuccess, resultValue: response.result.value, statusCode: response.response?.statusCode, apiDescription: endPoint, completion: { (statusCode, json, error) in
                    completion(statusCode: statusCode, json: json, error: error)
                })
        }
        
    } else {
        print("No Internet")
        completion(statusCode: noInternetCode, json: nil, error: nil)
    }
}

func handleAPIResultsFromTheModelSide(isSuccess: Bool, resultValue: AnyObject?, statusCode: Int?, apiDescription: String, completion: (statusCode: Int?, json: JSON?, error: String?) -> ()) {
    
    if isSuccess {
        
        // Check if there is an API generated error
        let json = JSON(resultValue!)
        
        // There was no API error, handle it and return
        if json != nil {
            completion(statusCode: statusCode, json: json, error: nil)
            return
            
            // There was no API error, but the result was probably not JSON
        } else {
            print("\(apiDescription): Not able to get JSON")
        }
    } else {
        print("Request unsuccessful: \(resultValue)")
    }
    completion(statusCode: statusCode, json: nil, error: nil)
}

func checkInternetConnectivity() -> Bool {
    let reachability: Reachability
    do {
        reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
        return false
    }
    
    let networkStatus = reachability.currentReachabilityStatus
    return networkStatus != .NotReachable
}