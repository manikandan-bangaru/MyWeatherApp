//
//  WeatherResponse.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation

class WeatherResponse: Decodable {
    var coord : Coord?
    var weather : [Weather]?
    var base : String?
    var main : Main?
    var visibility : Int?
    var wind : Wind?
    var clouds : Clouds?
    var dt : Int64?
    var sys : System?
    var timeZone : Int?
    var id : Int64?
    var name : String?
    var cod : Int?
}

public class Coord: Decodable {
    var lon : Float
    var lat : Float
}

class Weather: Decodable {
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
}
class  Main: Decodable {
    var temp : Float?
    var feels_like : Float?
    var temp_min : Float?
    var temp_max : Float?
    var pressure : Int?
    var humidity : Float?
    
}
class Wind: Decodable {
    var speed : Float?
    var deg : Float?
}
class Clouds: Decodable {
    var all : Int?
}
class System: Decodable {
    var type : Int?
    var id : Int64?
    var country : String?
    var sunrise : Int64?
    var sunset : Int64?
}
