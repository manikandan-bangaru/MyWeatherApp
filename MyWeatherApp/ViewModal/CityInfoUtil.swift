//
//  CityInfoUtil.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 08/06/21.
//

import Foundation


class CityInfoUtil
{
    
   static var shared = CityInfoUtil()
    //ToAvoid Duplication we are using dict , using id as unique value
     private var myFavCities : [Int64 : WeatherViewModal]?
    
   
    func updateCurrentWeatherInfo(weatherModal : WeatherViewModal){
        let coord = weatherModal.getCoord()
        NotificationCenter.default.post(name: Notification.UpdateWeatherNotificationName, object: coord, userInfo: nil)
    }
    func getFavCities() -> [WeatherViewModal]?{
        var cities = [WeatherViewModal]()
        if let myfavCities = self.myFavCities{
            for city in myfavCities.values{
                    cities.append(city)
            }
            return cities
        }
        
        return nil
    }
    func addCityWeather(city : WeatherViewModal){
        if self.myFavCities == nil{
            self.myFavCities = [Int64 : WeatherViewModal]()
        }
        if  let id = city.getCityID(){
            self.myFavCities?[id ] = city
        }
    }
    func RemoveCityWeatherInfo(city : WeatherViewModal){
        if  let id = city.getCityID(){
        self.myFavCities?.removeValue(forKey: id)
        }
    }
}
