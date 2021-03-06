//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController{
    
    
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func searchTextEnd(_ sender: UITextField) {

    }
    

}

extension WeatherViewController: UITextFieldDelegate{
     @IBAction func searchPressed(_ sender: UIButton) {
            searchTextField.endEditing(true)
    //        searchTextField.placeholder = "asu"
    //        searchTextField.text = ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true)
            
    //        searchTextField.placeholder = "jaran"
    //        searchTextField.text = ""
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != ""{
                return true
            } else {
                searchTextField.placeholder = "isi o"
                return false
            }
            
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let city = searchTextField.text{
                weatherManager.fetchWeather(cityName: city)
            }
            
            searchTextField.text = ""
        }
}

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
           print(weather.temperature)
           DispatchQueue.main.async {
               self.cityLabel.text = weather.cityName
               self.temperatureLabel.text = weather.temperatureString
               self.conditionImageView.image = UIImage(systemName: weather.conditionName)
           }
           
       }
       
       func didFailWithError(error: Error) {
           print(error.localizedDescription)
       }
}



