//
//  SearchCityResponse.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation

class SearchCityResponse: Decodable {
    var message : String?
    var cod : String?
    var count : Int?
    var list : [WeatherResponse]?
}
