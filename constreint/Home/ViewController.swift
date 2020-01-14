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
        self.cityName = favoritCity
        self.choseListCity = favoritCity
        print("NnNNNNNNNN")
    }
    
    
    @IBOutlet weak var fiveDayForecastMainScreen: UITableView!
    @IBOutlet weak var twentyHouersForecastMainScreen: UICollectionView!
    @IBOutlet weak var temperatureMainScreen: UILabel!
    @IBOutlet weak var cityNameMainScreen: UILabel!
    
    //var complitionHandler: ((String) -> ())?
    var delegatSafariData : SafariPassDataProtocol?
    
    
    
    
    var delegat : ListViewController?
    var choseListCity : String?{
        didSet{
            
            fetchCityBy(name: choseListCity ?? "Lviv")
            reloadInputViews()
        }
    }
                  
    
    
    var cityKey : String? {
        didSet {
            print(cityKey)
            fetchOneDayForecast(by: cityKey ?? " " )
            fetchFiveDayForecast(by: cityKey ?? " ")
            fetchtwentyHours (by: cityKey ?? " ")
            
        }
    }
    
    var cityName: String? {
        didSet {
            DispatchQueue.main.async {
                self.cityNameMainScreen.text = self.cityName
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("choseListCity ==>> \(choseListCity)")
        
        fetchCityBy(name: choseListCity ?? "Lviv")
        fiveDayForecastMainScreen.dataSource = self
        fiveDayForecastMainScreen.delegate = self
        twentyHouersForecastMainScreen.delegate = self
        twentyHouersForecastMainScreen.dataSource = self
        
        print("!!!!!!")
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ide"{
           let VC = segue.destination as! ListViewController
           print("SSSSSSSSSSS")
           VC.delegat = self
           }
       }
    
    
    @IBAction func linkPressSafari(_ sender: Any) {
        let passingName = cityName ?? " "
        let passingKey = cityKey ?? " "
        delegatSafariData?.passCityData(name: passingName, key: passingKey)
        //navigationController?.popViewController(animated: true)
        print(passingKey)
        print(passingName)
    }
    
    
    
    
    
    @IBAction func but(_ sender: Any) {
        let passingName = cityName ?? " "
               let passingKey = cityKey ?? " "
               delegatSafariData?.passCityData(name: passingName, key: passingKey)
        //navigationController?.popToViewController(SafariViewViewController(),  animated: true)
         self.navigationController?.popViewController(animated: true)
               print(passingKey)
               print(passingName)
    }
    // MARK: - Actions:
    // linkAction -> open safary by link swift
    
    
    func fetchCityBy(name: String) {
        
        guard let url = URL(string: "https://dataservice.accuweather.com/locations/v1/cities/search?q=\(name)&apikey=\(apiKey)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, eror) in
            guard  let data = data else { return }
    
            do {
                let cities = try JSONDecoder().decode([CityData].self, from: data)
                self.cityKey = cities[0].key
                self.cityName = cities[0].localizedName
                print(cities[0].localizedName)
                print("f1")
                
            } catch {
                print("error fetchCityBy ==>> \(error)")
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        print("ex1")
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Day Information"
        }else{
            return "Sun Information"
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
            
            var dayInformationInFiveForecastCell = fiveDayForecastMainScreen.dequeueReusableCell(withIdentifier: "idDayInformationInFiveForecastCell") as! DailyForecastTableViewCell
            
            if dayInformationInFiveForecastCell == nil{
                dayInformationInFiveForecastCell = UITableViewCell.init(style: .default, reuseIdentifier: "idDayInformationInFiveForecastCell") as! DailyForecastTableViewCell
            }
            print("@@@@@@@@@@@@")
            dayInformationInFiveForecastCell.dayInFiveDayForecast.text = dataDay(isoDate: self.fiveDayForecast[indexPath.row]?.date ?? " ")
            dayInformationInFiveForecastCell.minTemprInFiveDayForecast.text = String(self.fiveDayForecast[indexPath.row]!.temperature.maximum.value)
            dayInformationInFiveForecastCell.maxTemprInFiveDayForecast.text = String(self.fiveDayForecast[indexPath.row]!.temperature.minimum.value)
            
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
        
        houersInformationCell.namberHouerInTwentyForecast.text = String(hours(isoDate: String(self.twentyHours[indexPath.row]!.dateTime)))
        houersInformationCell.temperatureInTwentyForecast.text = String(self.twentyHours[indexPath.row]!.temperature.value )
        
        return houersInformationCell
    }
    
   
}
