//
//  ViewController.swift
//  constreint
//
//  Created by iStaff on 11/20/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ListProtocol {
    
    func setCity(favoritCity: String) {
        
        fetchCityBy(name: favoritCity) { city in
            DispatchQueue.main.async {
                self.cityNameMainScreen.text = city[0].localizedName
                self.cityKey = city[0].key
                self.fetchOneDayForecast(by: city[0].key )
                self.fetchFiveDayForecast(by: city[0].key)
                self.fetchtwentyHours (by: city[0].key)
            }
        }
    }
    
    
    @IBOutlet weak var fiveDayForecastMainScreen: UITableView!
    @IBOutlet weak var twentyHouersForecastMainScreen: UICollectionView!
    @IBOutlet weak var temperatureMainScreen: UILabel!
    @IBOutlet weak var cityNameMainScreen: UILabel!
    
    var delegat : ListViewController?
  
    var cityKey = ""

    
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
                self.fiveDayForecastMainScreen.reloadData()
                self.twentyHouersForecastMainScreen.reloadData()
            }
        }
    }
    
    var fiveDayForecast: [FiveDailyForecast?] = [] {
        didSet {
            DispatchQueue.main.async {
            }
        }
    }
    
    var start : [String] = UserDefaults.standard.object(forKey: "CITY") as? [String] ?? []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
              self.navigationController?.setNavigationBarHidden(true, animated: animated) // <<
        }
    
    override func viewWillDisappear(_ animated: Bool) {
             self.navigationController?.setNavigationBarHidden(false, animated: animated); // <<
             super.viewWillDisappear(animated)
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if start.count == 0{
            fetchCityBy(name: "Vinnitsia") { city in
                DispatchQueue.main.async {
                    print("start.count == 0")
                }
                
            }
        }else{
            fetchCityBy(name:  start[0]) { city in
                DispatchQueue.main.async {
                    self.cityNameMainScreen.text = city[0].localizedName
                    self.cityKey = city[0].key
                    self.fetchOneDayForecast(by: city[0].key )
                    self.fetchFiveDayForecast(by: city[0].key)
                    self.fetchtwentyHours (by: city[0].key)
                }
                
            }
        }
        
        
        fiveDayForecastMainScreen.dataSource = self
        fiveDayForecastMainScreen.delegate = self
        twentyHouersForecastMainScreen.delegate = self
        twentyHouersForecastMainScreen.dataSource = self
        
        
//        print("!!!!!!")
       
    }
    
    
    
    
    @IBAction func safariLink(_ sender: Any) {
        //performSegue(withIdentifier: "safariLinkId", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           if segue.identifier == "listViewSegue"{
           let controller: ListViewController = segue.destination as! ListViewController
           controller.delegat = self
           }
            
            if segue.identifier == "safariLinkId" {
                (segue.destination as! SafariLinkViewController).cityKey = cityKey
                (segue.destination as! SafariLinkViewController).cityName = self.cityNameMainScreen.text
            }
       }
    
    
    
    
    
    
    
    func fetchOneDayForecast(by cityKey: String?) {
        
        guard  let cityKey = cityKey, let url = URL(string: "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
            
            do{
                let dayForecast = try JSONDecoder().decode(OneDay.self, from: data)
                self.oneDayForecast = dayForecast.dailyForecasts
                print("f2")
            }catch{
                print(error)
            }
            }.resume()
    }
    
    
    
    
    func fetchFiveDayForecast (by cityKey: String){
        
        guard  let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
            
            do{
                let fiveForecast = try JSONDecoder().decode(FiveDay.self, from: data)
                self.fiveDayForecast = fiveForecast.dailyForecasts
                print("f3")
            }catch{
                print(error)
            }
            }.resume()
    }
    
    
    func fetchtwentyHours (by cityKey: String){
        
        guard  let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(cityKey)?apikey=\(apiKey)&details=true&metric=true") else{ return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else {
                return
                
            }
            do{
                let twentyHoursForecast = try JSONDecoder().decode([TwelveHoursForecast].self, from: data)
                self.twentyHours = twentyHoursForecast
                print("f4")
            }catch{
                print(error)
            }
            
            }.resume()
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fiveDayForecastMainScreen.deselectRow(at: indexPath, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2

    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0{
//            return "Day Information"
//        }else{
//            return "Sun Information"
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return fiveDayForecast.count
        }else{
            return oneDayForecast.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section % 2 == 0 {
            
            var dayInformationInFiveForecastCell = fiveDayForecastMainScreen.dequeueReusableCell(withIdentifier: "idDayInformationInFiveForecastCell") as! DailyForecastTableViewCell
            
            if dayInformationInFiveForecastCell == nil{
                dayInformationInFiveForecastCell = UITableViewCell.init(style: .default, reuseIdentifier: "idDayInformationInFiveForecastCell") as! DailyForecastTableViewCell
            }
            
            print("@@@@@@@@@@@@")
            
            if indexPath.row == 0{
                dayInformationInFiveForecastCell.dayInFiveDayForecast.text = "Today"
            }else{
                dayInformationInFiveForecastCell.dayInFiveDayForecast.text = dataDay(isoDate: self.fiveDayForecast[indexPath.row]?.date ?? " ")
            }
            
            dayInformationInFiveForecastCell.minTemprInFiveDayForecast.text = String(self.fiveDayForecast[indexPath.row]!.temperature.maximum.value)
            dayInformationInFiveForecastCell.maxTemprInFiveDayForecast.text = String(self.fiveDayForecast[indexPath.row]!.temperature.minimum.value)
            
            tableView.backgroundColor = .clear
            dayInformationInFiveForecastCell.backgroundColor = .clear
            tableView.tableFooterView = UIView()
            
            
            
            
            return dayInformationInFiveForecastCell
        } else {
            var sunInformationCell = fiveDayForecastMainScreen.dequeueReusableCell(withIdentifier: "idSunInformationCell") as! SunInfoTableViewCell
            
            if sunInformationCell == nil{
                sunInformationCell = UITableViewCell.init(style: .default, reuseIdentifier: "idSunInformationCell") as! SunInfoTableViewCell
            }
            
            let sunRiseHours = hours(isoDate: oneDayForecast[indexPath.row].sun.rise)
            let sunRiseMinutes = minutes(isoDate: oneDayForecast[indexPath.row].sun.rise)
            let sunSetHours = hours(isoDate: oneDayForecast[indexPath.row].sun.set)
            let sunSetMinutes = minutes(isoDate: oneDayForecast[indexPath.row].sun.set)
            
            sunInformationCell.sunRiseName.text = "sun rise"
            sunInformationCell.sunRiseTime.text = "\(sunRiseHours):\(sunRiseMinutes)"
            sunInformationCell.sunSetName.text = "sun set"
            sunInformationCell.sunSetTime.text = "\(sunSetHours):\(sunSetMinutes)"
            
            tableView.backgroundColor = .clear
            sunInformationCell.backgroundColor = .clear
            tableView.tableFooterView = UIView()
            
            
            
            return sunInformationCell
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("ex2")
        return twentyHours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let houersInformationCell = twentyHouersForecastMainScreen.dequeueReusableCell(withReuseIdentifier: "idHouersInformationCell", for: indexPath) as! HourlyForecastCollectionViewCell
        
        if indexPath.row == 0{
            houersInformationCell.namberHouerInTwentyForecast.text = "Now"
        }else{
            houersInformationCell.namberHouerInTwentyForecast.text = String(hours(isoDate: String(self.twentyHours[indexPath.row]!.dateTime)))
        }
        
        houersInformationCell.temperatureInTwentyForecast.text = String(self.twentyHours[indexPath.row]!.temperature.value )
        
        collectionView.backgroundColor = .clear
        houersInformationCell.backgroundColor = .clear
        //collectionView.collectionFooterView = UIView()
        
        
        
        return houersInformationCell
    }
}
