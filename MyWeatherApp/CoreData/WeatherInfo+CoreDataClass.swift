//
//  WeatherInfo+CoreDataClass.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//
//

import Foundation
import CoreData

@objc(WeatherInfo)
public class WeatherInfo: NSManagedObject {
    
      
    convenience init(id : Int64,time : String?,response : WeatherResponse, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "WeatherInfo", in: context) {
            self.init(entity: ent, insertInto: context)
            self.id = id
            self.icon_name = response.weather?.first?.icon
            self.time = time
            self.place_name = response.name
            self.place_country = response.sys?.country
            if let t = response.main?.temp{
                self.temp = String(t)

            }
            if let t_min = response.main?.temp_min{
                self.min_temp = String(t_min)

            }
            if let t_max = response.main?.temp_min{
                self.max_temp = String(t_max)

            }
            self.weather_desc = response.weather?.first?.description
            if let lat = response.coord?.lat{
                self.latitude = String(lat)

            }
            if let lon = response.coord?.lon{
                self.longitude = String(lon)

            }
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    func getWeatherViewModal() -> WeatherViewModal{
        let response = WeatherResponse()
        let time =  time

        response.id = id
        response.weather = [Weather()]
        response.weather?.first?.icon =  self.icon_name
        response.name = self.place_name
        response.sys = System()
        response.sys?.country = self.place_country
        
        response.main = Main()
        if let t = self.temp {
            response.main?.temp = Float(t)
        }
        if let t_min = min_temp {
            response.main?.temp_min = Float(t_min)

        }
        if let t_max = max_temp {
            response.main?.temp_max = Float(t_max)

        }
        
        response.weather?.first?.description =  self.weather_desc
        response.coord = Coord()
        if let lat = self.latitude{
            response.coord?.lat = Float(lat)

        }
        if let lon = self.longitude{
            response.coord?.lon = Float(lon)

        }
        
        
        return WeatherViewModal(response: response,time: time)
    }
    class func addData(id : Int64,time: String? ,response : WeatherResponse, context: NSManagedObjectContext){
        
        let _ = WeatherInfo(id : id, time: time ,response : response, context: context)
        do{
            try  CoreDataStack.shared?.context.save()
            
        }catch{
            
        }
    }
    class  func retriveWeatherDetails() -> [WeatherViewModal]?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherInfo")
        
        
        do {
            let results = try CoreDataStack.shared?.context.fetch(fetchRequest)
            if let results = results as? [WeatherInfo]{
               var weatherModals = [WeatherViewModal]()
                for result in results{
                    
                    let modal = result.getWeatherViewModal()
                    weatherModals.append(modal)
                }
                return weatherModals
            }
            
        } catch {
            
            print("Failed")
        }
         return nil
    }
}
