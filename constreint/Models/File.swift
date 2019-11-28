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
struct City: Decodable {
    let key: String
    let localizedName: String
    //"Key": "1-326175_1_AL"
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
    }
}
//five
struct Five: Decodable {
    let dailyForecasts: [fiveDailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct fiveDailyForecast: Decodable {
    let date: String
    let temperature: fiveTemperature
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case temperature = "Temperature"
    }
}


struct fiveTemperature: Decodable {
    let minimum: fiveImum
    let maximum: fiveImum
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

struct fiveImum: Decodable {
    let value: Double
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}

// one
struct Welcome: Decodable {
    let dailyForecasts: [DailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}


struct DailyForecast: Decodable {
    let date: String
    let sun: Sun
    let temperature: Temperature
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case sun = "Sun"
        case temperature = "Temperature"
    }
}


struct Sun: Decodable {
    let rise: String
    let sunSet: String
    
    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case sunSet = "Set"
    }
}


struct Temperature: Decodable {
    let minimum: Imum
    let maximum: Imum
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}


struct Imum: Decodable {
    let value: Double
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}


//12hour
struct WelcomeElement: Decodable {
    let dateTime: String
    let temperature: Temperature12
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case temperature = "Temperature"
    }
}

struct Temperature12: Decodable {
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        
    }
}
