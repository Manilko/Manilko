//
//  CityService.swift
//  constreint
//
//  Created by iStaff on 11/23/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation


func fetchCityBy(name: String,  handler: @escaping (([CityData])->())) {
        
        guard let url = URL(string: "https://dataservice.accuweather.com/locations/v1/cities/search?q=\(name)&apikey=\(apiKey)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
    
            do {
                let cities = try JSONDecoder().decode([CityData].self, from: data)
                handler(cities)

            } catch {
                print("error fetchCityBy ==>> \(error)")
            }
            }.resume()
    }

