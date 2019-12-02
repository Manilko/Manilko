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
    @IBOutlet weak var temperatureMainScreen: UILabel!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var cityKey : String? {
        didSet {
          
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
    
    var oneDayForecast: [OneDailyForecast] = [] {
        didSet {
            DispatchQueue.main.async {
                self.temperatureMainScreen.text = String(self.oneDayForecast[0].temperature.maximum.value)
            }
        }
    }
    
    var twentyHours: [TwelveHoursForecast?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.dayTabel.reloadData()
                self.colectionView.reloadData()
                
            }
        }
    }
    
    var fiveDayForecast: [FiveDailyForecast?] = [] {
        didSet {
            DispatchQueue.main.async {
               
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
       
    }
    
    func fetchCityBy(name: String) {
        
        guard let url = URL(string: "https://dataservice.accuweather.com/locations/v1/cities/search?q=\(name)&apikey=\(apiKey)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
    
            do {
                let cities = try JSONDecoder().decode([CityData].self, from: data)
                self.cityKey = cities[0].key
                self.cityName = cities[0].localizedName
            } catch {
                print(error)
            }
            
            }.resume()
        
        
    }
    
    
    func fetchOneDayForecast(by cityKey: String?) {
        
        guard  let cityKey = cityKey, let url = URL(string: "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
            
            do{
                let dayForecast = try JSONDecoder().decode(OneDay.self, from: data)
                self.oneDayForecast = dayForecast.dailyForecasts
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
            
            do{
                let fiveForecast = try JSONDecoder().decode(FiveDay.self, from: data)
                self.fiveDayForecast = fiveForecast.dailyForecasts
            }catch{
                print(error)
            }
            }.resume()
    }
    
    
    func fetchtwentyHours (by: String){
        
        guard  let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(by)?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else {
                return
                
            }
            do{
                let twentyHoursForecast = try JSONDecoder().decode([TwelveHoursForecast].self, from: data)
                self.twentyHours = twentyHoursForecast
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
            cell.lab.text = dataDay(isoDate: self.fiveDayForecast[indexPath.row]?.date ?? " ")
            cell.la2.text = String(self.fiveDayForecast[indexPath.row]!.temperature.maximum.value)
            cell.label.text = String(self.fiveDayForecast[indexPath.row]!.temperature.minimum.value)
            
            return cell
        } else {
            var secondCell = dayTabel.dequeueReusableCell(withIdentifier: "idSecondCell") as! SunInfoTableViewCell
            
            if secondCell == nil{
                secondCell = UITableViewCell.init(style: .default, reuseIdentifier: "idSecondCell") as! SunInfoTableViewCell
            }
            secondCell.l1.text = "sun rise"
            
//            let sunriseHours = hours(isoDate: oneDayForecast[indexPath.row].sun.rise)
//            let sunriseMinutes = minutes(isoDate: oneDayForecast[indexPath.row].sun.rise)
            secondCell.l2.text = "\(hours(isoDate: oneDayForecast[indexPath.row].sun.rise)):\(minutes(isoDate: oneDayForecast[indexPath.row].sun.rise))"
            secondCell.l3.text = "sun set"
            secondCell.l4.text = "\(hours(isoDate: oneDayForecast[indexPath.row].sun.set)):\(minutes(isoDate: oneDayForecast[indexPath.row].sun.set))"
            return secondCell
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return twentyHours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let colcell = colectionView.dequeueReusableCell(withReuseIdentifier: "idCellCol", for: indexPath) as! HourlyForecastCollectionViewCell
        
        colcell.labe1.text = String(hours(isoDate: String(self.twentyHours[indexPath.row]!.dateTime)))
        colcell.label2.text = String(self.twentyHours[indexPath.row]!.temperature.value )
        
        return colcell
    }
}
