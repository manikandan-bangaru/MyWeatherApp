//
//  WeatherInfo+CoreDataProperties.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//
//

import Foundation
import CoreData


extension WeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfo> {
        return NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
    }
    @NSManaged public var id: Int64
    @NSManaged public var time: String?
    @NSManaged public var place: String?
    @NSManaged public var temp: String?
    @NSManaged public var min_temp: String?
    @NSManaged public var max_temp: String?
    @NSManaged public var desc: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

}

extension WeatherInfo : Identifiable {

}
