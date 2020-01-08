//
//  WeatherManager.swift
//  Clima
//
//  Created by Daniel Ye on 7/1/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL =
        "https://api.openweathermap.org/data/2.5/weather?appid=427f272d3f05ada14c81d2fdf1827d35"
    let unit = "&units=metric"
    let query = "&q="
    
    func fetchWeather(cityName: String) {
        let urlString = weatherURL + unit + query + cityName
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            
            task.resume()
            
        }
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let cityName = decodedData.name
            let weatherDescription = decodedData.weather[0].description
            
            return WeatherModel(conditionId: id, temperature: temperature, cityName: cityName, weatherDescription: weatherDescription)
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
