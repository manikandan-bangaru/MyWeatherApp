//
//  WeatherRequestParamConstants.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation

class WeatherRequestParamConstants {
    
    static let Host = "https://api.openweathermap.org"
    static let Units = "units"
    static let API_Key_value : String = {
        if let key = Bundle.main.infoDictionary?["API_KEY"] as? String{
            return key
        }
        print("Weather API key not found")
        return ""
    }()
    struct UnitValues {
        static let Metric = "metric" // degree celcius
        static let Standard = "standard"
        static let imperial = "imperial"
    }
    static let SearchCityPath = "/data/2.5/find"
    static let WeatherSearchPath = "/data/2.5/weather"
    
    struct Params {
        static let APIKey = "appid"
        static let CityInfo = "q" // degree celcius
        static let Latitude = "lat"
        static let Longitude = "lon"
        static let cityID = "id"
        static let zipCode = "zip"
    }
}
