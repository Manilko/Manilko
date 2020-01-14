//
//  SafariViewViewController.swift
//  constreint
//
//  Created by iStaff on 1/14/20.
//  Copyright © 2020 iStaff. All rights reserved.
//

import UIKit

class SafariViewViewController: UIViewController {

    @IBOutlet weak var safariLink: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let url = URL(string: "https://www.accuweather.com/en/ua/vinnytsia/326175/current-weather/326175?lang=en-gb&partner=1000001070_hfaw")
        safariLink.loadRequest(URLRequest(url: url!))
       
    }
    

}
