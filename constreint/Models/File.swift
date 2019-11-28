//
//  File.swift
//  constreint
//
//  Created by iStaff on 11/22/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation


let apiKey = "Dw6geMn6cIOKson61Kz4IRgEWTbZpkoJ"

// city
struct CityData: Decodable {
    let key: String
    let localizedName: String
    //"Key": "1-326175_1_AL"
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
    }
}
//five
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

// one
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


//12hour
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
