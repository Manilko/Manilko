//
//  FiveDayModels.swift
//  constreint
//
//  Created by iStaff on 12/7/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

struct FiveDay: Decodable {
    let dailyForecasts: [FiveDailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct FiveDailyForecast: Decodable {
    let date: String
    let temperature: FiveDayTemperature
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case temperature = "Temperature"
    }
}


struct FiveDayTemperature: Decodable {
    let minimum: FiveDayTemperatureValue
    let maximum: FiveDayTemperatureValue
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

struct FiveDayTemperatureValue: Decodable {
    let value: Double
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
