//
//  CitiesCell.swift
//  WeatherTest
//
//  Created by Ibrahim Aleidan on 04/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class CitiesCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    func configure(withCity city: City){
        cityNameLabel.text = city.name
    }

}
