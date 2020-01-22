//
//  SearchCity.swift
//  constreint
//
//  Created by iStaff on 1/17/20.
//  Copyright © 2020 iStaff. All rights reserved.
//

import Foundation

func fetchCitySearch(by leters: String, complition: @escaping (([CityData])->())){
    
     guard let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/autocomplete?q=\(leters)&apikey=\(apiKey)") else { return }
             
             let session = URLSession.shared
             session.dataTask(with: url) { (data, response, eror) in
                 guard  let data = data else { return }
         
                 do{
                   let cities = try JSONDecoder().decode([CityData].self, from: data)
                     //print(cities)
                    //self.selectedСities = cities
                    complition(cities)
                    //print(self.fETCHcITIES)
                 }catch{
                     print("ERROR_CitySearch==>>\(error)")
                 }
                 }.resume()
}
