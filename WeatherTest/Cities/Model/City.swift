//
//  City.swift
//  WeatherTest
//
//  Created by Ibrahim Aleidan on 04/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

struct City {
    let id: Int
    let name: String
    let country:String
    let coord: Location
    
    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
            let name = dict["name"] as? String,
            let country = dict["country"] as? String,
            let coord = dict["coord"] as? [String: Any]
            else {return nil}
        
        self.id = id
        self.name = name
        self.country = country
        guard let loc = Location(dict: coord)  else { return nil }
        self.coord = loc
    }
}
