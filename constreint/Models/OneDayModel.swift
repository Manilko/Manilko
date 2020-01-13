//
//  OneDayModel.swift
//  constreint
//
//  Created by iStaff on 12/7/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

struct OneDay: Decodable {
    let dailyForecasts: [OneDailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}


struct OneDailyForecast: Decodable {
    let date: String
    let sun: Sun
    let temperature: OneDayTemperature
    //TODO: MobileLink
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case sun = "Sun"
        case temperature = "Temperature"
    }
}


struct Sun: Decodable {
    let rise: String
    let set: String
    
    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case set = "Set"
    }
}


struct OneDayTemperature: Decodable {
    let minimum: OneDayTemperatureValue
    let maximum: OneDayTemperatureValue
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}


struct OneDayTemperatureValue: Decodable {
    let value: Double
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
