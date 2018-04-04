//
//  CitiesController.swift
//  WeatherTest
//
//  Created by Asim al twijry on 04/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class CitiesController: UIViewController {
    
    var cites: [City]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cityProvider.request(.severalCities("524901,703448,2643743")) { result in
            
                switch result{
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode(SeveralCities.self, from: response.data)
                        print(results.cnt! )
                        print(results.list![0])

                    } catch {
                        let printableError = error as CustomStringConvertible
                        self.showAlert("cityProvider Fetch", message: printableError.description)
                    }
                case let .failure(err):
                    print(err)
            }
            
            
        }
    }

    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
