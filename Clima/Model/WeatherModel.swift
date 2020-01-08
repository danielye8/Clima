//
//  WeatherModel.swift
//  Clima
//
//  Created by Daniel Ye on 8/1/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

let iconFill = ""

struct WeatherModel {
    let conditionId: Int
    let temperature: Double
    let cityName: String
    let weatherDescription: String
    
    
    var temperatureString : String {
        return String(format: "%.0f", temperature)
    }
    
    // compute property
    var conditionName: String {
        
        var output : String
        
        switch conditionId {
        case 200 ... 299:
            output = "cloud.bolt"
        case 300 ... 399:
            output = "cloud.drizzle"
        case 500 ... 599:
            output = "cloud.rain"
        case 600 ... 699:
            output = "snow"
        case 700 ... 799:
            output = "cloud.fog"
        case 800:
            output = "sun.max"
        case 801 ... 899:
            output = "cloud"
        default:
            output =  "questionmark.circle"
        }
        
        return output + iconFill
    }
}

