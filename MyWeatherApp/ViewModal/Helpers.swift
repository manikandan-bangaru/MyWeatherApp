//
//  Helpers.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 08/06/21.
//

import Foundation
import UIKit
extension Notification{
    static var UpdateWeatherNotificationName : Notification.Name{
        Notification.Name.init("_UpdateWeatherLocation")
    }
    static var RefreshManageCitiesVCNN : Notification.Name{
        Notification.Name.init("_RefreshManageCitiesVCNN")
    }
}

class Constants {
   static let viewbgColor = #colorLiteral(red: 0.8722413182, green: 0.9628625512, blue: 0.9590582252, alpha: 1)
    static let searchVCTitle = "Search Cities"
}
