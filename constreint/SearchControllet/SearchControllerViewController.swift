//
//  SearchControllerViewController.swift
//  constreint
//
//  Created by iStaff on 12/5/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import UIKit

// TODO: In another file
class CitySearchTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
}

// TODO: to the bottom




class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fETCHcITIES: [CityData] = []
    {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var selectCity: [String] = []
    
    //var savedCities = UserDefaults.standard.array(forKey: "cities") as? [String] ?? []
    
    var cities: [CityData] = [CityData(key: "sds", localizedName: "Lviv")]
    // TODO:
    var delegateList: ListViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSearch()
        
        
    }
    
    func setupSearch (){
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    
    }
    
    
    func fetchCitySearch(by leters: String){
        
         guard let url = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/autocomplete?q=\(leters)&apikey=\(apiKey)") else { return }
                 
                 let session = URLSession.shared
                 session.dataTask(with: url) { (data, response, eror) in
                     guard  let data = data else { return }
             
                     do{
                       let cities = try JSONDecoder().decode([CityData].self, from: data)
                         //print(cities)
                        self.fETCHcITIES = cities
                        //print(self.fETCHcITIES)
                     }catch{
                         print("ERROR_CitySearch==>>\(error)")
                     }
                     }.resume()
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fETCHcITIES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitySearchCell") as? CitySearchTableViewCell
        
        if fETCHcITIES.count != 0 {
            cell?.cityLabel.text = fETCHcITIES[indexPath.row].localizedName
        }
        //print(" fETCHcITIES ==> \(fETCHcITIES)")
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        print(searchController.searchBar.text)
        guard let text = searchController.searchBar.text else {return}
        
        let minCountLeters = 2
        if text.count > minCountLeters {
            fetchCitySearch(by: text)
        }else{
            fETCHcITIES.removeAll()
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  //##!!!!!!!!
        // TODO:
        //delegate.selectCity(cities[indexPath.row])
    //selectCity.append(fETCHcITIES[indexPath.row].localizedName)
        let chous = fETCHcITIES[indexPath.row].localizedName
        print(fETCHcITIES[indexPath.row].localizedName)
        
        selectCity = UserDefaults.standard.object(forKey: "CITY") as? [String] ?? []
        print("selectCity ==>> \(selectCity)")
        
        var flag = 0
        
        if selectCity.count < 1 {
            selectCity.append(chous)
        }
            else{
            for i in selectCity{
                //print(i)
                if chous != i{
                    flag += 1
                }
                print("flag\(flag)  selectCity.count\(selectCity.count) ")
                if flag == selectCity.count {
                    selectCity.append(chous)
                }
            }
        }
        //navigationController?.pushViewController(ListViewController(), animated: true)
        //present(ListViewController() , animated: true, completion: nil)
        
        
        
        
        
        UserDefaults.standard.set(selectCity, forKey: "CITY")
        UserDefaults.standard.synchronize()
        print("2    selectCity ==>> \(selectCity)")
        _ = self.navigationController?.popViewController(animated: true)
        
        
        
        //navigationController?.pushViewController(TableViewController(), animated: true)
        //present(TableViewController() , animated: true, completion: nil)
        
        //navigationController?.pushViewController(ListViewController(), animated: true)
        //present(ListViewController() , animated: true, completion: nil)
        
        
        //print("2    delegateList?.listCity ==>> \(delegateList?.listCity)")
        
        
                                                //        fETCHcITIES.removeAll()
                                                //        dismiss(animated: true, completion: nil)
        
//    UserDefaults.standard.set(selectCity, forKey: "CITY")
//    UserDefaults.standard.synchronize()
        
        // Save city
        // get saved cities:
    
        // TODO: if not contains
        // add new selected city
    //savedCities.append(fETCHcITIES[indexPath.row].localizedName)
        // save changes
    //UserDefaults.standard.set(savedCities, forKey: "cities")
        
        
        
        // Save city
            // get saved cities:
        //var savedCities = UserDefaults.standard.array(forKey: "cities") as? [String] ?? []
            // TODO: if not contains
            // add new selected city
        //savedCities.append(cities[indexPath.row].localizedName)
            // save changes
        //UserDefaults.standard.set(savedCities, forKey: "cities")
            
    }
}
