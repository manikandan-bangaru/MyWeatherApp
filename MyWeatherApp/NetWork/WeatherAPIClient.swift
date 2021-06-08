//
//  WeatherAPIClient.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation

class WeatherAPIClient {
    
    static var shared = WeatherAPIClient()
    
    public func searchCity(apiURLComponents: WeatherRequestParams, completionHandlerForGET: @escaping HTTPGetRespHandler){
        if let url = apiURLComponents.getRequestURL(){
            APIClient.shared.cancelPreViousCalls()
            APIClient.shared.taskForGETMethod(url: url) { data, error in
                guard  error == nil else {
                    completionHandlerForGET(nil,error)
                    return
                }
                if let data = data{
                    do{
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(SearchCityResponse.self, from: data as! Data)
                        completionHandlerForGET(result,nil)
                    }catch{
                        
                    }
                }else{
                    completionHandlerForGET(nil,error)
                }
            }
        }else{
            completionHandlerForGET(nil,NSError(domain: "Invalid URL", code: 404, userInfo: nil))
        }
   
        
    }
    public func getWeather(apiURLComponents: WeatherRequestParams, completionHandlerForGET: @escaping HTTPGetRespHandler){
        if let url = apiURLComponents.getRequestURL(){
            APIClient.shared.taskForGETMethod(url: url) { data, error in
                guard  error == nil else {
                    completionHandlerForGET(nil,error)
                    return
                }
                if let data = data{
                    do{
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(WeatherResponse.self, from: data as! Data)
                        completionHandlerForGET(result,nil)
                    }catch{
                        
                    }
                }else{
                    completionHandlerForGET(nil,error)
                }
            }
        }else{
            completionHandlerForGET(nil,NSError(domain: "Invalid URL", code: 404, userInfo: nil))
        }
    }
}
