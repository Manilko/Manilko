////
////  DataServices.swift
////  constreint
////
////  Created by iStaff on 11/26/19.
////  Copyright © 2019 iStaff. All rights reserved.
////
//
//
//
//import Foundation
//import UIKit
//
//func dataAs(){
//
//let isoDate = "2019-11-26T07:00:00+02:00"
//
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
////dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
////dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//let formattedDate = dateFormatter.date(from: isoDate)!
//
//
//
//
//let calendar = Calendar.current
//let minutes = calendar.component(.minute, from: formattedDate)
//let hours = calendar.component(.hour, from: formattedDate)
//let day = calendar.component(.weekday, from: formattedDate)
//    
//    
//}
//    
//
//enum Day : String {
//    //    case one = "Sanday"
//    //    case two = "Mondey"
//    //    case three = "Thuesday"
//    //    case four = "Wednesday"
//    //    case five = "Thersday"
//    //    case six = "Friday"
//    //    case seven = "Saurday"
//    case one = "Sanday"
//    case two = "Mondey"
//    case three = "Thuesday"
//    case four = "Wednesday"
//    case five = "Thersday"
//    case six = "Friday"
//    case seven = "Saurday"
//    
//    
//}
//
//func dayOfWeak(day:Int){
//    switch day {
//    case 1: Day.one.rawValue
//    case 2: Day.two.rawValue
//    case 3: Day.three.rawValue
//    case 4: Day.four.rawValue
//    case 5: Day.five.rawValue
//    case 6: Day.six.rawValue
//    case 7: Day.seven.rawValue
//    default:
//        break
//    }
//}
//
////dayOfWeak(day: day)
//
