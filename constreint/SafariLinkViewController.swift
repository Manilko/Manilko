//
//  SafariLinkViewController.swift
//  constreint
//
//  Created by iStaff on 1/15/20.
//  Copyright © 2020 iStaff. All rights reserved.
//

import UIKit

class SafariLinkViewController: UIViewController {

    @IBOutlet weak var webSafari: UIWebView!
    
    var cityName: String?
    var cityKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runSafari(name: cityName ?? " ", key: cityKey ?? " ")
    }
    
    func runSafari(name: String, key: String)  {
              let url = URL(string: "https://www.accuweather.com/en/ua/\(name)/\(key)/current-weather/\(key)?lang=en-gb&partner=1000001070_hfaw")
      
              webSafari.loadRequest(URLRequest(url: url!))
          }
}
