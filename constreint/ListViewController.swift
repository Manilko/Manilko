//
//  ListViewController.swift
//  constreint
//
//  Created by iStaff on 1/2/20.
//  Copyright © 2020 iStaff. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    
    var delegat : List?
    var delegat1 : ViewController?
    var choseCity = ""
    
    var listCity : [String] = UserDefaults.standard.object(forKey: "CITY") as? [String] ?? []
//    {
//        didSet{
//            DispatchQueue.main.async{
//                self.tableView.reloadData()
//            }
//        }
//        
//    }
    
    var name : String = ""
    //(UserDefaults.standard.object(forKey: "CITY") as? String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.reloadData()
        
        //tableView.isEditing.
        
        print(listCity)
        
    }
    
    
    // Save city
        // get saved cities:
    //var savedCities = UserDefaults.standard.array(forKey: "cities") as? [String] ?? []
        // TODO: if not contains
        // add new selected city
    //savedCities.append(cities[indexPath.row].localizedName)
        // save changes
    //UserDefaults.standard.set(savedCities, forKey: "cities")
    
    
    
    
    
    
//    let dataVC = segue.destination as! secondViewController
//    dataVC.delegat = self
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var VC: ListViewController = segue.destination as! ListViewController
//
//    }
//    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipe = UIContextualAction(style: .normal , title: "tutttt") { (action, view, success) in
            print("secsess")
        }
        //swipe.backgroundColor.ciColor.alpha
        self.isEditing = true
        
        return UISwipeActionsConfiguration(actions: [swipe])
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveElement = listCity[sourceIndexPath.row]
        listCity.remove(at: sourceIndexPath.row)
        listCity.insert(moveElement, at: destinationIndexPath.row)
//        print("\(moveElement)   ==>> \(destinationIndexPath.row)")
//        print(listCity)
        UserDefaults.standard.set(listCity, forKey: "CITY")
        UserDefaults.standard.synchronize()
        isEditing = false
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let swipe = UIContextualAction(style: .normal , title: "tutttt") { (action, view, success) in
//                    print("secsess")
//                }
//                swipe.backgroundColor.ciColor.alpha
//
//
//                return UISwipeActionsConfiguration(actions: [swipe])
//    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            listCity.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            UserDefaults.standard.set(listCity, forKey: "CITY")
            UserDefaults.standard.synchronize()
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listCity.count
        //return 1
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listIdCell", for: indexPath) as! TListCityCell
        
        if listCity.count != 0{
            cell.listCityLabel.text = listCity[indexPath.row]
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("happy \(listCity[indexPath.row])")
         choseCity = listCity[indexPath.row]
//        delegat1?.choseListCity = choseCity
        print(choseCity)
//        delegat1?.fetchCityBy(name: listCity[indexPath.row])
        //present(ViewController() , animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        //navigationController?.pushViewController(ViewController(), animated: true)
        _ = self.navigationController?.popViewController(animated: true)
        delegat?.setCity(favoritCity: choseCity)
        
        
    }
    
   

}

