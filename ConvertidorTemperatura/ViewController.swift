//
//  ViewController.swift
//  ConvertidorTemperatura
//
//  Created by Elian Arizmendi on 16/08/21.
//

import UIKit

class ViewController: UIViewController {
    let temperatureConverter = TemperatureConverter()
    let temperatureConverterService = TemperatureConverterService()
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func convertToFahrenheit(_ sender: UIButton) {
        fahrenheitTextField.text = ""
                
                if let celsiusValue = celsiusTextField.text {
                    if !celsiusValue.isEmpty {
                        
                         let fahrenheitValue = temperatureConverter.convert(temperature: Temperature(value: Float16(celsiusValue)!, unit: Temperature.Unit.CELSIUS), unitToConvert: Temperature.Unit.FAHRENHEIT)
                        print("Farenheit " + String(fahrenheitValue.value))
                        fahrenheitTextField.text = String(fahrenheitValue.value)
                         
                        /*
                        let originalTemperature = Temperature(value: Float16(celsiusValue)!, unit: Temperature.Unit.CELSIUS)
                        
                        temperatureConverterService.convertToFahrenheit(temperature: originalTemperature)  {
                                [weak self] (fahrenheitTemperature) in
                                    DispatchQueue.main.async {
                                    self?.fahrenheitTextField.text = String(fahrenheitTemperature.value)
                                            }
                                            
                                        }
                         */

                    } else {
                        print("Celsius value is empty")
                    }
                }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showHistory" {
                let controller = (segue.destination as! ListViewController)
                
                temperatureConverterService.retrieveHistory() {
                    (history) in
                    DispatchQueue.main.async {
                        controller.history = history
                        controller.tableView.reloadData()
                    }
                }
                
            }
        }
}
