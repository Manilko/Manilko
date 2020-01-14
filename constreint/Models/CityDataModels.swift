//
//  CityDataModels.swift
//  constreint
//
//  Created by iStaff on 12/7/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import Foundation

struct CityData: Decodable {
    let key: String
    let localizedName: String
    //"Key": "1-326175_1_AL"
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
    }
}
