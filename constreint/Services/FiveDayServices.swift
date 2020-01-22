//
//  FiveDayServices.swift
//  constreint
//
//  Created by iStaff on 12/7/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

//func fetchFiveDayForecast (by cityKey: String){
//    
//    guard  let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
//    
//    let session = URLSession.shared
//    session.dataTask(with: url) { (data, response, eror) in
//        guard  let data = data else { return }
//        
//        do{
//            let fiveForecast = try JSONDecoder().decode(FiveDay.self, from: data)
//            self.fiveDayForecast = fiveForecast.dailyForecasts
//        }catch{
//            print(error)
//        }
//        }.resume()
//}
