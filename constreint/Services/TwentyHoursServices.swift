//
//  TwentyHoursServices.swift
//  constreint
//
//  Created by iStaff on 12/7/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

func fetchtwentyHours (by cityKey: String, complition_hand: @escaping (([TwelveHoursForecast?])->())){
    
    guard  let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
    
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, eror) in
        guard  let data = data else {
            return
            
        }
        do{
            let twentyHoursForecast = try JSONDecoder().decode([TwelveHoursForecast].self, from: data)
            //self.twentyHours = twentyHoursForecast
            complition_hand(twentyHoursForecast)
            print("f4")
        }catch{
            print(error)
        }
        
        }.resume()
}
