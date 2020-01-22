//
//  ListViewController.swift
//  constreint
//
//  Created by iStaff on 1/2/20.
//  Copyright © 2020 iStaff. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    
    var delegat : ListProtocol?
    var choseCity = ""
    
    var A = ""
    
    var listCity : [String] = UserDefaults.standard.object(forKey: "CITY") as? [String] ?? []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.setNavigationBarHidden(false, animated: false)

        print(listCity)
        
        let image = UIImage(named: "39142-priroda-poslesvechenie-den-atmosfera-nebo-1125x2436")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        //imageView.alpha = 0.2
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipe = UIContextualAction(style: .normal , title: "tutttt") { (action, view, success) in
            print("secsess")
        }
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
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCitycell = tableView.dequeueReusableCell(withIdentifier: "listIdCell", for: indexPath) as! ListCityCell
        
        if listCity.count != 0{
            listCitycell.listCityLabel.text = listCity[indexPath.row]
        }
        
        tableView.backgroundColor = .clear
        listCitycell.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        return listCitycell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("happy \(listCity[indexPath.row])")
         choseCity = listCity[indexPath.row]
        print(choseCity)
        _ = self.navigationController?.popViewController(animated: true)
        delegat?.setCity(favoritCity: choseCity)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "id"{
            let controller = segue.destination as! SearchViewController
            controller.complition = { info in
                self.A = info
                
                var flag = 0
                
                if self.listCity.count < 1 {
                    self.listCity.append(info)
                }else{
                    for i in self.listCity{
                                //print(i)
                                if info != i{
                                    flag += 1
                                }
                        print("flag\(flag)  selectCity.count\(self.listCity.count) ")
                        if flag == self.listCity.count {
                            self.listCity.append(info)
                                }
                            }
                        }
                UserDefaults.standard.set(self.listCity, forKey: "CITY")
                UserDefaults.standard.synchronize()
                self.tableView.reloadData()
            }
        }
    }
    
    
    
}

//extension ListViewController {
//    @IBInspectable var backgroundImage: UIImage? {
//        get {
//            return nil
//        }
//        set {
//            backgroundImage = UIImageView(image: newValue)
//
//        }
//    }
//}
