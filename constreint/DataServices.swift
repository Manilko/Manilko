//
//  DataServices.swift
//  constreint
//
//  Created by iStaff on 11/26/19.
//  Copyright © 2019 iStaff. All rights reserved.


import Foundation
import UIKit

func dataDay(isoDate: String)->String{

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let formattedDate = dateFormatter.date(from: isoDate)!

let calendar = Calendar.current
let day = calendar.component(.weekday, from: formattedDate)
var result: String?
    switch day {
                        case 1:  result = "Sanday"
                        case 2:  result = "Mondey"
                        case 3:  result = "Thuesday"
                        case 4:  result = "Wednesday"
                        case 5:  result = "Thersday"
                        case 6:  result = "Friday"
                        case 7:  result = "Saurday"
                        default:
                            break
                }
    return result ?? " "
//enum Day : String {
//    case one = "Sanday"
//    case two = "Mondey"
//    case three = "Thuesday"
//    case four = "Wednesday"
//    case five = "Thersday"
//    case six = "Friday"
//    case seven = "Saurday"
//
//    var title: String {
//        var result: String
//        switch day {
//                case 1:  result = Day.one.rawValue
//                case 2:  result = Day.two.rawValue
//                case 3:  result = Day.three.rawValue
//                case 4:  result = Day.four.rawValue
//                case 5:  result = Day.five.rawValue
//                case 6:  result = Day.six.rawValue
//                case 7:  result = Day.seven.rawValue
//                default:
//                    break
//        }
//        return result
//    }
}

func hours(isoDate: String)->Int{
    
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
