//
//  Location.swift
//  WeatherTest
//
//  Created by Ibrahim Aleidan on 04/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
    
    init?(dict: [String: Any]) {
        guard let latitude = dict["lat"] as? Double,
            let longitude = dict["lon"] as? Double
            else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude
    }
}
