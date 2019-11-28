//
//  ViewController.swift
//  constreint
//
//  Created by iStaff on 11/20/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dayTabel: UITableView!
    @IBOutlet weak var colectionView: UICollectionView!
    // todo temperatureLabel
    @IBOutlet weak var t: UILabel!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var cityKey : String? {
        didSet {
            //            DispatchQueue.main.async {
            //self.cityNameLabel.text = self.cityKey
            
            //            }
            
            
            // fetchCityName(by: cityKey ?? " ") - add this function
            fetchOneDayForecast(by: cityKey)
            fetchFiveDayForecast(by: cityKey ?? " ")
            fetchtwentyHours (by: cityKey ?? " ")
        }
    }
    
    var cityName: String? {
        didSet {
            DispatchQueue.main.async {
                self.cityNameLabel.text = self.cityName
            }
        }
    }
    
    var oneDayForecast: [DailyForecast] = [] {
        didSet {
            DispatchQueue.main.async {
                //                self.t.text = String(self.oneDayForecast!.temperature.maximum.value)
                //print(String(self.oneDayForecast[0].temperature.maximum.value))
                //self.t.text = "kjbvjerbv"
                
            }
        }
    }
    
    var twentyHours: [WelcomeElement?] = [] {
        didSet {
            //            for i in 0..<self.twentyHours.count{
            //                print("\(i) \(self.twentyHours[i])")
            //                self.zzzTwentyHours.append(self.twentyHours[i])
            //print(self.zzzTwentyHours)
            
            //}
            DispatchQueue.main.async {
                //                print(self.twentyHours[0])
                //                print(self.twentyHours[1])
                self.dayTabel.reloadData()
                self.colectionView.reloadData()
                
            }
        }
    }
    
    var fiveDayForecast: [fiveDailyForecast?] = [] {
        didSet {
            DispatchQueue.main.async {
                //print(self.fiveDayForecast[2])
                //print(self.fiveDayForecast.count)
                //
                //                for i in 0..<self.fiveDayForecast.count{
                //                    print(self.fiveDayForecast[i]?.date)
                //                }
                //                for i in 0..<self.fiveDayForecast.count{
                //                    print(self.fiveDayForecast[i]?.temperature.maximum.value)
                //                }
                //                for i in 0..<self.fiveDayForecast.count{
                //                    print(self.fiveDayForecast[i]?.temperature.minimum.value)
                //                }
                
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayTabel.dataSource = self
        dayTabel.delegate = self
        colectionView.delegate = self
        colectionView.dataSource = self
        
        // hardcode
        fetchCityBy(name: "Vinnytsia")
        
        print("!!!!!!")
        //print(zzzTwentyHours)
        
        
        //print(cityKey)
        //c.text = city
    }
    
    func fetchCityBy(name: String) {
        
        guard let url = URL(string: "https://dataservice.accuweather.com/locations/v1/cities/search?q=\(name)&apikey=\(apiKey)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
            //print(data)
            //guard let response = response else { return }
            //print(response)
            
            do {
                let cities = try JSONDecoder().decode([City].self, from: data)
                self.cityKey = cities[0].key
                self.cityName = cities[0].localizedName
            } catch {
                print(error)
            }
            
            }.resume()
        //print(cityKey)
        
    }
    
    
    func fetchOneDayForecast(by cityKey: String?) {
        
        guard  let cityKey = cityKey, let url = URL(string: "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
            //print(data)
            //guard let response = response else { return }
            //print(response)
            
            do{
                let dayForecast = try JSONDecoder().decode(Welcome.self, from: data)
                self.oneDayForecast = dayForecast.dailyForecasts
                //self.oneDayForecast = dayForecast.dailyForecasts[1]
                //print(self.oneDayForecast)
            }catch{
                print(error)
            }
            
            }.resume()
    }
    
    
    
    
    func fetchFiveDayForecast (by: String){
        
        guard  let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/1-326175_1_AL?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
            //print(data)
            //guard let response = response else { return }
            //print(response)
            
            do{
                let fiveForecast = try JSONDecoder().decode(Five.self, from: data)
                self.fiveDayForecast = fiveForecast.dailyForecasts
                //                for i in 0..<fiveForecast.dailyForecasts.count{
                //                self.fiveDayForecast.append(fiveForecast.dailyForecasts[i])
                //                    print(i)
                //                }
                //                self.fiveDayForecast.append(fiveForecast.dailyForecasts[0])
                //                self.fiveDayForecast.append(fiveForecast.dailyForecasts[1])
            }catch{
                print(error)
            }
            }.resume()
    }
    
    
    func fetchtwentyHours (by: String){
        
        guard  let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(by)?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
            //print(data)
            //guard let response = response else { return }
            //print(response)
            
            do{
                let twentyHoursForecast = try JSONDecoder().decode([WelcomeElement].self, from: data)
                //print(json[0])
                self.twentyHours = twentyHoursForecast
                //self.twentyHours?.append(json[0])
                //                json[0].dateTime
                //                json[0].temperature.value
                //                json[11].dateTime
                //                json[11].temperature.value
                //self.twentyHours = json[0].
            }catch{
                print(error)
            }
            
            }.resume()
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return " Section day"
        }else{
            return " Section SUN Rite SUN set"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            //print(self.fiveDayForecast.count)
            return fiveDayForecast.count
        }else{
            return oneDayForecast.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section % 2 == 0 {
            
            var cell = dayTabel.dequeueReusableCell(withIdentifier: "idCell") as! DailyForecastTableViewCell
            
            if cell == nil{
                cell = UITableViewCell.init(style: .default, reuseIdentifier: "idCell") as! DailyForecastTableViewCell
            }
            print("@@@@@@@@@@@@")
            //            for i in 0..<fiveDayForecast.count{
            //                cell.lab.text = self.fiveDayForecast[i]?.date
            //            }
            //cell.lab.text = self.fiveDayForecast[1]?.date
            cell.lab.text = dataDay(isoDate: self.fiveDayForecast[indexPath.row]?.date ?? " ")
            cell.la2.text = String(self.fiveDayForecast[indexPath.row]!.temperature.maximum.value)
            cell.label.text = String(self.fiveDayForecast[indexPath.row]!.temperature.minimum.value)
            
            return cell
        } else {
            var secondCell = dayTabel.dequeueReusableCell(withIdentifier: "idSecondCell") as! SunInfoTableViewCell
            
            if secondCell == nil{
                secondCell = UITableViewCell.init(style: .default, reuseIdentifier: "idSecondCell") as! SunInfoTableViewCell
            }
            //String(hours(isoDate: oneDayForecast?.sun.rise ?? " "))
            secondCell.l1.text = "sun rise"
            
            let sunriseHours = hours(isoDate: oneDayForecast[indexPath.row].sun.rise)
            let sunriseMinutes = minutes(isoDate: oneDayForecast[indexPath.row].sun.rise)
            secondCell.l2.text = "\(sunriseHours):\(sunriseMinutes)"
            //            let str = String((oneDayForecast?.sun.rise)!)
            //            let min = hours(isoDate: str)
            //            print( min )
            
            secondCell.l3.text = "sun set"
            secondCell.l4.text = oneDayForecast[indexPath.row].sun.sunSet
            return secondCell
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return twentyHours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var colcell = colectionView.dequeueReusableCell(withReuseIdentifier: "idCellCol", for: indexPath) as! HourlyForecastCollectionViewCell
        
        colcell.labe1.text = String(hours(isoDate: String(self.twentyHours[indexPath.row]!.dateTime)))
        colcell.label2.text = String(self.twentyHours[indexPath.row]!.temperature.value )
        
        return colcell
    }
}
