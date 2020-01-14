//
//  SafariViewViewController.swift
//  constreint
//
//  Created by iStaff on 1/14/20.
//  Copyright © 2020 iStaff. All rights reserved.
//

import UIKit

class SafariViewViewController: UIViewController, SafariPassDataProtocol {

  
    var cityName: String?
    var cityKey: String?{
        didSet{
            print("aaaaaaaa")
            //runSafari(name: cityName ?? " ", key: cityKey ?? " ")
        }
    }
    
    

    @IBOutlet weak var safariLink: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      print(cityName)
        print(cityKey)
        
        //passCityData(name: " ", key: " ")
       //runSafari(name: cityName ?? " ", key: cityKey ?? " ")
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("secsecc")
//        if segue.identifier == "idSafariCont"{
//            let dascriptionViewCont : ViewController = segue.destination as! ViewController
//            dascriptionViewCont.delegatSafariData = self
//
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("secsecc")
        if segue.identifier == "id"{
            let dascriptionViewCont = segue.destination as! ViewController
            dascriptionViewCont.delegatSafariData = self
            
        }
    }
    
    func passCityData(name: String, key: String) {
        print("+++++++++++++++++++++")
        cityName = name
        cityKey = key
    }

    
    func runSafari(name: String, key: String)  {
            let url = URL(string: "https://www.accuweather.com/en/ua/\(name)/\(key)/current-weather/\(key)?lang=en-gb&partner=1000001070_hfaw")
    //   let url = URL(string: "https://www.accuweather.com/en/ua/Lviv/324561/current-weather/324561?lang=en-gb&partner=1000001070_hfaw")
            safariLink.loadRequest(URLRequest(url: url!))
        }
    
}
