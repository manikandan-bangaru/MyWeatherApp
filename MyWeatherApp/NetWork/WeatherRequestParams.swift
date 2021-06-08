//
//  WeatherRequestParams.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation

public class APIRequestParams {
    var  host : String
    var  path : String
    public init(apiPath : String)
    {
        self.path = apiPath
        self.host = WeatherRequestParamConstants.Host
    }
    public class APIRequestParamsBuilder {
        var apiPath: String

        init(apiPath: String) {
            self.apiPath = apiPath
        }
    }
}
public class WeatherRequestParams: APIRequestParams {
    
    var cityName : String?
    var cityID : String?
    var zipCode : String?
    var countryCode : String?
    var latitude : String?
    var longitude : String?
    init(apiPath : String , builder : SearchCityParamBuilder) {
        self.cityName = builder.cityName
        super.init(apiPath: apiPath)
    }
    init(apiPath : String , builder : WeatherSearchParamBuilder) {
        self.cityName = builder.cityName
        self.cityID = builder.cityID
        self.zipCode = builder.zipCode
        self.countryCode = builder.countryCode
        self.latitude = builder.latitude
        self.longitude = builder.longitude
        super.init(apiPath: apiPath)
    }
    
    public func getRequestURL() -> URL?{
        var params  = [String : AnyObject]()
        
        var cityInfo = String()
        
        if let ci = cityID{
            params[WeatherRequestParamConstants.Params.cityID] = ci as AnyObject
        }
        if let zc = zipCode{
            cityInfo = zc
            if let cc = countryCode {
                cityInfo += cc
            }
        }else {
            if let cn = cityName {
                cityInfo = cn
            }
        }
            
        params[WeatherRequestParamConstants.Params.CityInfo] = cityInfo as AnyObject
        
        if let lat = self.latitude {
            params[WeatherRequestParamConstants.Params.Latitude] = lat as AnyObject

        }
        if let lon = self.longitude {
            params[WeatherRequestParamConstants.Params.Longitude] = lon as AnyObject

        }
        
        
        
        var urlComponents = URLComponents(string: self.host)
        urlComponents?.path = self.path
        urlComponents?.queryItems = [URLQueryItem]()
        
        for (key, value) in params{
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents?.queryItems?.append(queryItem)
        }
        
        //Adding Metrics for degree celcius
        let unitsQuery = URLQueryItem(name: WeatherRequestParamConstants.Units, value: "\(WeatherRequestParamConstants.UnitValues.Metric)")
        urlComponents?.queryItems?.append(unitsQuery)
        //Adding API Key
        let apiKey = URLQueryItem(name: WeatherRequestParamConstants.Params.APIKey, value: "\(WeatherRequestParamConstants.API_Key_value)")
        urlComponents?.queryItems?.append(apiKey)
        return urlComponents?.url
    }
    
    public  class SearchCityParamBuilder: APIRequestParams.APIRequestParamsBuilder {
        var cityName : String?
         init() {
            super.init(apiPath: WeatherRequestParamConstants.SearchCityPath)
        }
        
        func set(cityName : String){
            self.cityName = cityName
        }
        func build() -> WeatherRequestParams{
            return WeatherRequestParams(apiPath: self.apiPath, builder: self)
        }
    }
    public class WeatherSearchParamBuilder: APIRequestParams.APIRequestParamsBuilder {
        var cityName : String?
        var cityID : String?
        var zipCode : String?
        var countryCode : String?
        var latitude : String?
        var longitude : String?
        init() {
            super.init(apiPath: WeatherRequestParamConstants.WeatherSearchPath)
        }
        
        func set(cityName : String) -> WeatherSearchParamBuilder {
            self.cityName = cityName
            return self
        }
        func set(latitude : String , longitude : String) -> WeatherSearchParamBuilder{
            self.latitude = latitude
            self.longitude = longitude
            return self
        }
        func set(cityID : String) -> WeatherSearchParamBuilder {
            self.cityID = cityID
            return self
        }
        func set(zipCode : String , countryCode :String) -> WeatherSearchParamBuilder{
            self.zipCode = zipCode
            self.countryCode = countryCode
            return self
        }
        func build() -> WeatherRequestParams{
            return WeatherRequestParams(apiPath: self.apiPath, builder: self)
        }
    }
}
