//
//  ViewController.swift
//  applik
//
//  Created by Лиза Евсеева on 15.02.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
    }
    
    @objc func didTapGetWeatherButton() {
        myLabel.text = "Please wait..."
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.myLabel.text = "\(weather.current.temperature2M)\(weather.currentUnits.temperature2M)"
                }
                print(weather.current.temperature2M)
            } else {
                print("Fail")
            }
        }
        task.resume()
    }

}

