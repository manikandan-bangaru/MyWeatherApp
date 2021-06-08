//
//  Helpers.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 08/06/21.
//

import Foundation

extension Notification{
    static var UpdateWeatherNotificationName : Notification.Name{
        Notification.Name.init("_UpdateWeatherLocation")
    }
}
