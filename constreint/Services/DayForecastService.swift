//
//  DayForecastService.swift
//  constreint
//
//  Created by iStaff on 11/22/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

func AZX (apiKey: String, cityKey: String){
    
    guard  let url = URL(string: "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apiKey)=true&metric=true") else{ return }
    
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, eror) in
        guard  let data = data else { return }
        //print(data)
        guard let response = response else { return }
        //print(response)
        
        do{
            let json = try JSONDecoder().decode(OneDay.self, from: data)
            print(json)
            json.dailyForecasts[0].temperature.maximum.value
        }catch{
            print(error)
        }
        
        }.resume()
}

