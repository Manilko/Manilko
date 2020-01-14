//
//  OneDayServices.swift
//  constreint
//
//  Created by iStaff on 12/7/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

//func fetchOneDayForecast(by cityKey: String?) {
//
//    guard  let cityKey = cityKey, let url = URL(string: "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
//
//    let session = URLSession.shared
//    session.dataTask(with: url) { (data, response, eror) in
//        guard  let data = data else { return }
//
//        do{
//            let dayForecast = try JSONDecoder().decode(OneDay.self, from: data)
//            self.oneDayForecast = dayForecast.dailyForecasts
//        }catch{
//            print(error)
//        }
//
//        }.resume()
//}
