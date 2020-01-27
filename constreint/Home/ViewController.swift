//
//  ViewController.swift
//  constreint
//
//  Created by iStaff on 11/20/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ListProtocol {
    
    
    @IBOutlet weak var fiveDayForecastMainScreen: UITableView!
    @IBOutlet weak var twentyHouersForecastMainScreen: UICollectionView!
    @IBOutlet weak var temperatureMainScreen: UILabel!
    @IBOutlet weak var cityNameMainScreen: UILabel!
    
    func setCity(favoritCity: String) {
        fetchCityBy(name: favoritCity) { city in
            DispatchQueue.main.async {
                self.cityNameMainScreen.text = city.first?.localizedName
                self.cityKey = city.first?.key ?? ""
                fetchOneDayForecast(by: city.first?.key) { forecasts in
                    self.oneDayForecast = forecasts
                }
                fetchFiveDayForecast(by: city.first?.key ?? "") { fiveForecast in
                    self.fiveDayForecast = fiveForecast
                }
                fetchtwentyHours (by: city.first?.key ?? "") { twelveForecast in
                    self.twentyHours = twelveForecast
                }
            }
        }
    }
    
    
    var delegat : ListViewController?
  
    var cityKey = ""
    var fiveDayForecast: [FiveDailyForecast?] = []
    var twentyHours: [TwelveHoursForecast?] = []

    
    var oneDayForecast: [OneDailyForecast] = [] {
        didSet {
            DispatchQueue.main.async {
                self.temperatureMainScreen.text = String(self.oneDayForecast.first!.temperature.maximum.value)
                self.fiveDayForecastMainScreen.reloadData()
                self.twentyHouersForecastMainScreen.reloadData()
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
        
            fetchCityBy(name:  start.first ?? "Vinnytsia") { city in
                DispatchQueue.main.async {
                    self.cityNameMainScreen.text = city.first?.localizedName
                    self.cityKey = city.first?.key ?? ""
                   fetchOneDayForecast(by: city.first?.key) { forecasts in
                        //print("@@@@@@@@@@ =>> \(forecasts)")
                        self.oneDayForecast = forecasts
                    }
                    fetchFiveDayForecast(by: city.first?.key ?? "") { fiveForecast in
                    self.fiveDayForecast = fiveForecast
                    }
                    fetchtwentyHours(by: city.first?.key ?? "") { twelveForecast in
                    self.twentyHours = twelveForecast
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
            print(oneDayForecast.count)
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
