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


class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var complition: ((String)->())?
    
    var selectedСities: [CityData] = []
    {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var selectCitySearch: [String] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let image = UIImage(named: "39142-priroda-poslesvechenie-den-atmosfera-nebo-1125x2436")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        //imageView.alpha = 0.2
        self.setupSearch()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
               navigationController!.navigationBar.shadowImage = UIImage()
               navigationController?.navigationBar.isTranslucent = true
               navigationController?.view.backgroundColor = UIColor.clear
                
    }
    
    func setupSearch (){
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchResultsUpdater = self
        

        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear

    
        
    }
    
    
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedСities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitySearchCell") as? CitySearchTableViewCell
        
        if selectedСities.count != 0 {
            cell?.cityLabel.text = selectedСities[indexPath.row].localizedName
        }
        //print(" fETCHcITIES ==> \(fETCHcITIES)")
        
        tableView.backgroundColor = .clear
        cell?.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        print(searchController.searchBar.text ?? "searchBar.text Don't work")
        guard let text = searchController.searchBar.text else {return}
        
        let minCountLeters = 2
        if text.count > minCountLeters {
            fetchCitySearch(by: text) { data in
                self.selectedСities = data
            }
        }else{
            selectedСities.removeAll()
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    
<<<<<<< HEAD
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
=======
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  //##!!!!!!!!
>>>>>>> 8cc3251dd6bdaa7a3abacc9621821abd1053153f
        
        let chous = selectedСities[indexPath.row].localizedName
        print(selectedСities[indexPath.row].localizedName)
        complition!(chous)
        
<<<<<<< HEAD
=======
        selectCitySearch = UserDefaults.standard.object(forKey: "CITY") as? [String] ?? []
        print("selectCity ==>> \(selectCitySearch)")
        
        var flag = 0
        
        if selectCitySearch.count < 1 {
            selectCitySearch.append(chous)
        }
            else{
            for i in selectCitySearch{
                //print(i)
                if chous != i{
                    flag += 1
                }
                print("flag\(flag)  selectCity.count\(selectCitySearch.count) ")
                if flag == selectCitySearch.count {
                    selectCitySearch.append(chous)
                }
            }
        }
        
        UserDefaults.standard.set(selectCitySearch, forKey: "CITY")
        UserDefaults.standard.synchronize()
        print("2    selectCity ==>> \(selectCitySearch)")
>>>>>>> 8cc3251dd6bdaa7a3abacc9621821abd1053153f
        _ = self.navigationController?.popViewController(animated: true)
        
      
    }
}
