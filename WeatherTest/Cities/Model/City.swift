//
//  City.swift
//  WeatherTest
//
//  Created by Ibrahim Aleidan on 04/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

struct City:Decodable {
    let id: Int
    let name: String
    let country:String
    let coord: Location
    
}
