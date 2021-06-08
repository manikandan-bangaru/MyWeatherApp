//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 06/06/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var timelabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var max_TempLabel: UILabel!
    
    @IBOutlet weak var min_TempLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
     var locationCoord : LocationCoord?{
        didSet{
            guard let locationCoord = locationCoord else {
                return
            }
            let lat  = String(format : "%.4f", locationCoord.lat)
            let lon  = String(format : "%.4f",locationCoord.lon)
            self.fetchWeatherFor(cityName: nil, lat: lat, lon: lon)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherViewModal : WeatherViewModal?{
        
        didSet{
            DispatchQueue.main.async {
                self.placeLabel.text = self.weatherViewModal?.getPlace()
                self.timelabel.text = self.weatherViewModal?.getTime()
                self.currentTempLabel.text = self.weatherViewModal?.getCurrentTemp()
                self.min_TempLabel.text = self.weatherViewModal?.getMinTemp()
                self.max_TempLabel.text = self.weatherViewModal?.getMaxTemp()
                self.weatherDescriptionLabel.text = self.weatherViewModal?.getWeatherDescription()
                
                self.weatherImageView.image = self.weatherViewModal?.getIcon()
            }
         
        }
    }
    var locationManager : CLLocationManager!
    var locationRequestSent : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation), name: Notification.UpdateWeatherNotificationName, object: nil)
        // Do any additional setup after loading the view.
//        fetchWeatherFor(cityName: "Krishnagiri")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //MARK: To update Message
//        let coord = LocationCoord(lat: 12.0, lon: 12.0)
//        NotificationCenter.default.post(name: Notification.UpdateWeatherNotificationName, object: coord, userInfo: nil)
    }
    @objc func updateLocation(_ sender : Notification){
        if let locationCoord = sender.object as? LocationCoord{
            self.locationCoord = locationCoord
        }
    }
    func fetchWeatherFor(cityName : String? , lat : String? ,lon : String?){
        
        var weatherParamBuilder = WeatherRequestParams.WeatherSearchParamBuilder()
            if let cn = cityName{
                weatherParamBuilder =  weatherParamBuilder.set(cityName: cn)
                
            }
        if let lat = lat , let lon = lon{
            weatherParamBuilder =  weatherParamBuilder.set(latitude: lat, longitude: lon)
        }
       let weatherComponents =  weatherParamBuilder.build()
        
        WeatherAPIClient.shared.getWeather(apiURLComponents: weatherComponents) { response, error in
            
            if let weatherResponse = response as? WeatherResponse{
                DispatchQueue.main.async {
                    self.weatherViewModal = WeatherViewModal(response: weatherResponse)
                }
                
            }
        }
        
    }

    
}

extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locationRequestSent == false{
            self.locationRequestSent = true
        locationManager.stopUpdatingLocation()
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
      
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
       
        locationCoord = LocationCoord(lat: locValue.latitude, lon: locValue.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

