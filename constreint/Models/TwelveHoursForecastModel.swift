//
//  TwelveHoursForecastModel.swift
//  constreint
//
//  Created by iStaff on 12/7/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

struct TwelveHoursForecast: Decodable {
    let dateTime: String
    let temperature: TwelveHoursTemperatureForecast
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case temperature = "Temperature"
    }
}

struct TwelveHoursTemperatureForecast: Decodable {
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        
    }
}
