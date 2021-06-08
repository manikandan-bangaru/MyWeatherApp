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
    init(response : WeatherResponse) {
        self.weatherResponse = response
    }
    
    
    func getPlace() -> String{
        return (weatherResponse?.name ?? "") + " , " + (weatherResponse?.sys?.country ?? "")
    }
    func getTime() -> String {
        let dateformate = DateFormatter()
        dateformate.dateFormat = "HH:MM a , E MMM dd"
        return dateformate.string(from: Date())
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
        case "01d.png" , "01n.png" : // clear SKY
            systemIconName = "cloud"
        case "02d.png" , "02n.png" : // few clouds
            systemIconName = "cloud"
        case "03d.png" , "03n.png" : // scattered clouds
            systemIconName = "cloud"
        case "04d.png" , "04n.png" : //broken clouds
            systemIconName = "cloud"
        case "09d.png" , "09n.png" : // shower rain
            systemIconName = "cloud"
        case "10d.png" , "10n.png" : // rain
            systemIconName = "cloud"
        case "11d.png" , "11n.png" : // thunderstorm
            systemIconName = "cloud"
        case "13d.png" , "13n.png" : // snow
            systemIconName = "cloud"
        case "50d.png" , "50n.png" : // mist
            systemIconName = "cloud"
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
}
