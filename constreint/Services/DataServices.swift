//
//  DataServices.swift
//  constreint
//
//  Created by iStaff on 11/26/19.
//  Copyright © 2019 iStaff. All rights reserved.


import Foundation
import UIKit

func dataDay(isoDate: String) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let formattedDate = dateFormatter.date(from: isoDate)!
    
    let calendar = Calendar.current
    let day = calendar.component(.weekday, from: formattedDate)
    var result: String?
    switch day {
    case 1:  result = "Sunday"
    case 2:  result = "Monday"
    case 3:  result = "Tuesday"
    case 4:  result = "Wednesday"
    case 5:  result = "Thursday"
    case 6:  result = "Friday"
    case 7:  result = "Saturday"
    default:
        break
    }
    return result ?? " "
}

func hours(isoDate: String) -> Int {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let formattedDate = dateFormatter.date(from: isoDate)!
    
    let calendar = Calendar.current
    let hours = calendar.component(.hour, from: formattedDate)
    return hours
}



func minutes(isoDate: String)->Int{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let formattedDate = dateFormatter.date(from: isoDate)!
    
    let calendar = Calendar.current
    let minutes = calendar.component(.minute, from: formattedDate)
    return minutes
}
