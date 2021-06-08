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
            self.fetchWeatherFor(cityID: nil, cityName: nil, lat: lat, lon: lon)
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
         
            self.moreInfoDataSet = [MoreInfoData]()
            if let info = self.weatherViewModal?.getHumidity(){
                let moreinfo = MoreInfoData(type: .humidity, value: info)
                moreInfoDataSet.append(moreinfo)
            }
            if let info = self.weatherViewModal?.getWindSpeed(){
                let moreinfo = MoreInfoData(type: .windSpeed, value: info)
                moreInfoDataSet.append(moreinfo)
            }
            if let info = self.weatherViewModal?.getPressure(){
                let moreinfo = MoreInfoData(type: .pressure, value: info)
                moreInfoDataSet.append(moreinfo)
            }
            if let info = self.weatherViewModal?.getVisibility(){
                let moreinfo = MoreInfoData(type: .visibility, value: info)
                moreInfoDataSet.append(moreinfo)
            }
            if moreInfoDataSet.count == 0{
                self.collectionView.isHidden = true
            }
            else{
                self.collectionView.isHidden = false
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var moreInfoDataSet = [MoreInfoData]()
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
        
        //Chennai is default location
      
        //MARK: To update Message
        self.collectionView.register(MoreInfoCollectionCell.nib, forCellWithReuseIdentifier: MoreInfoCollectionCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        fetchCitiesFromDB()
    }
    func loadDefaultCitydetails(){
        //Chennai
        if let cities =  WeatherInfo.retriveWeatherDetails() , cities.count == 0{
            let lat = 13.087800025939941
            let lon = 80.27850341796875
            self.locationCoord = LocationCoord(lat: lat, lon: lon)
        }
    }
    func fetchCitiesFromDB(){
        if let cities =   WeatherInfo.retriveWeatherDetails() , cities.count > 0{
            for (i,city) in cities.enumerated(){
                if i == 0{
                    self.weatherViewModal = city
                    //refresh details from cloud
                    if let id = city.getCityID(){
                        self.fetchWeatherFor(cityID: String(id), cityName: nil)
                    }
                }
                CityInfoUtil.shared.addCityWeather(city: city)
            }
        }else{
//            loadDefaultCitydetails()
        }
    }
    @objc func updateLocation(_ sender : Notification){
        if let locationCoord = sender.object as? LocationCoord{
            self.locationCoord = locationCoord
        }
    }
    func fetchWeatherFor(cityID : String?,cityName : String? , lat : String? = nil,lon : String? = nil){
        
        var weatherParamBuilder = WeatherRequestParams.WeatherSearchParamBuilder()
            if let cn = cityName{
                weatherParamBuilder =  weatherParamBuilder.set(cityName: cn)
                
            }
        if let lat = lat , let lon = lon{
            weatherParamBuilder =  weatherParamBuilder.set(latitude: lat, longitude: lon)
        }
        if let id = cityID{
            weatherParamBuilder =  weatherParamBuilder.set(cityID: id)
        }
       let weatherComponents =  weatherParamBuilder.build()
        
        WeatherAPIClient.shared.getWeather(apiURLComponents: weatherComponents) { response, error in
            
            if let weatherResponse = response as? WeatherResponse{
                DispatchQueue.main.async {
                   let weatherModal = WeatherViewModal(response: weatherResponse)
                    self.weatherViewModal = weatherModal
                    CityInfoUtil.shared.addCityWeather(city: weatherModal)
                    
                    if  let id = weatherModal.getCityID(){
                        let time = weatherModal.getTime()
                        
                        WeatherInfo.addData(id: id, time: time, response: weatherResponse, context: CoreDataStack.shared!.context)
                    }
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
        loadDefaultCitydetails()
    }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moreInfoDataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: MoreInfoCollectionCell.identifier, for: indexPath) as? MoreInfoCollectionCell{
            
            cell.moreinfoData = self.moreInfoDataSet[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    
    
}
