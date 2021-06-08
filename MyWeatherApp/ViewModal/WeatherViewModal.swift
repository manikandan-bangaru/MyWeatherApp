//
//  WeatherViewModal.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation
import UIKit
class WeatherViewModal {

    private var weatherResponse : WeatherResponse?
    private var time : String?
    init(response : WeatherResponse , time : String? = nil) {
        self.weatherResponse = response
        self.time = time
    }
    
    
    func getCityID() -> Int64?{
        return self.weatherResponse?.id
    }
    func getPlace() -> String{
        return (weatherResponse?.name ?? "") + " , " + (weatherResponse?.sys?.country ?? "")
    }
    func getTime() -> String {
        
        let dateformate = DateFormatter()
        dateformate.dateFormat = "HH:MM a , E MMM dd"
        return self.time ?? dateformate.string(from: Date())
    }
    func getIcon() -> UIImage?{
//        01d.png      01n.png      clear sky
//        02d.png      02n.png      few clouds
//        03d.png      03n.png      scattered clouds
//        04d.png      04n.png      broken clouds
//        09d.png      09n.png      shower rain
//        10d.png      10n.png      rain
//        11d.png      11n.png      thunderstorm
//        13d.png      13n.png      snow
//        50d.png      50n.png      mist
        var systemIconName = "cloud"
        
        switch weatherResponse?.weather?.first?.icon {
        case "01d" , "01n" : // clear SKY
            systemIconName = "cloud"
        case "02d" , "02n" : // few clouds
            systemIconName = "cloud.sun"
        case "03d" , "03n" : // scattered clouds
            systemIconName = "cloud.fill"
        case "04d" , "04n" : //broken clouds
            systemIconName = "icloud"
        case "09d" , "09n" : // shower rain
            systemIconName = "cloud.drizzle"
        case "10d" , "10n" : // rain
            systemIconName = "cloud.rain"
        case "11d" , "11n" : // thunderstorm
            systemIconName = "cloud.bolt.rain"
        case "13d" , "13n" : // snow
            systemIconName = "cloud.snow"
        case "50d" , "50n" : // mist
            systemIconName = "cloud.fog"
        default:
            systemIconName = "cloud"
        }
        return UIImage(systemName: systemIconName)
    }
    func getCurrentTemp() -> String{
        if let temp = weatherResponse?.main?.temp{
            return "\(temp)"
        }else{
            return "-"
        }
        
    }
    func getMaxTemp() -> String{
        if let temp = weatherResponse?.main?.temp_max{
            return "\(temp)"
        }else{
            return "-"
        }    }
    func getMinTemp() -> String{
        if let temp = weatherResponse?.main?.temp_min{
            return "\(temp)"
        }else{
            return "-"
        }
    }
    func getWeatherDescription() -> String{
        return weatherResponse?.weather?.first?.description?.capitalized ?? ""
    }
    func getCoord() -> LocationCoord?{
        
        let lat = self.weatherResponse?.coord?.lat
        let lon = self.weatherResponse?.coord?.lon
        if let lat = lat ,let lon = lon{
            return LocationCoord(lat: Double(lat), lon: Double(lon))
        }
        return nil
    }
    func getWindSpeed() -> String?{
        if let info = weatherResponse?.wind?.speed{
            return String(info)
        }
        return nil
    }
    func getPressure() -> String?{
        if let info = weatherResponse?.main?.pressure{
            return String(info)
        }
        return nil
    }
    func getHumidity() -> String?{
        if let info = weatherResponse?.main?.humidity{
            return String(info)
        }
        return nil
    }
    func getVisibility() -> String?{
        if let info = weatherResponse?.visibility{
            return String(info)
        }
        return nil
    }
    func getResponse() -> WeatherResponse? {
        return self.weatherResponse
    }
    
}
