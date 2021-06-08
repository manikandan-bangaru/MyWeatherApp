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
    
      
    convenience init(id : Int64 ,time: String? ,place : String? , temp: String? , min_temp: String? , max_temp: String? , desc: String?  , latitude : String? , longitude : String?, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "WeatherInfo", in: context) {
            self.init(entity: ent, insertInto: context)
            self.time = time
            self.place = place
            self.temp = temp
            self.min_temp = min_temp
            self.max_temp = max_temp
            self.desc = desc
            self.latitude = latitude
            self.longitude = longitude
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    class func addData(id : Int64,time: String? ,place : String? , temp: String? , min_temp: String? , max_temp: String? , desc: String?  , latitude : String? , longitude : String?, context: NSManagedObjectContext){
        
        let _ = WeatherInfo(id : id, time: time ,place : place , temp: temp , min_temp: min_temp , max_temp: max_temp , desc: desc  , latitude : latitude , longitude : longitude, context: context)
        do{
            try  CoreDataStack.shared?.context.save()
            
        }catch{
            
        }
    }
    class  func retriveWeatherDetails() -> [WeatherInfo]?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherInfo")
        
        
        do {
            let result = try CoreDataStack.shared?.context.fetch(fetchRequest)
            if let result = result as? [WeatherInfo]{
                return result
            }
            
        } catch {
            
            print("Failed")
        }
         return nil
    }
}
