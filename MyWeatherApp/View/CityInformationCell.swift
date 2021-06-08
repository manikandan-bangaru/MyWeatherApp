//
//  CityInformationCell.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import UIKit

class CityInformationCell: UITableViewCell {

    @IBOutlet weak var place: UILabel!
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    var weatherInfo : WeatherViewModal?
    {
        didSet{
            self.place.text = weatherInfo?.getPlace()
            self.temp.text = weatherInfo?.getCurrentTemp()
            
            if let myfavCities = CityInfoUtil.shared.getFavCities(){
                for favCity in  myfavCities{
                    
                    if self.weatherInfo?.getCityID() == favCity.getCityID(){
                        self.addButton.isHidden = true
                        break
                    }else{
                        self.addButton.isHidden = false
                    }
                }
            }
        }
    }
    var parentVC : SearchLocationViewController?{
        didSet{
            self.addButton.isHidden = false
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addButton.isHidden = true
        self.backgroundColor = Constants.viewbgColor
        
        self.containerStackView.backgroundColor = .white
        self.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        self.containerStackView.layer.cornerRadius = 20
        
    }

  
    static var identifier : String{
        String(describing: self)
    }
    static var nib : UINib{
        UINib(nibName: identifier, bundle: Bundle.main)
    }
    
    @objc func addButtonTapped(){
        //Add Weather into fav cities
        if let wI = self.weatherInfo{
            CityInfoUtil.shared.addCityWeather(city: wI)
            NotificationCenter.default.post(name: Notification.RefreshManageCitiesVCNN, object: nil, userInfo: nil)
            parentVC?.dismiss(animated: true, completion: nil)
            
            let time = self.weatherInfo?.getTime()
            if let id = self.weatherInfo?.getCityID() ,let response = self.weatherInfo?.getResponse(){
                WeatherInfo.addData(id: id, time: time, response: response, context: CoreDataStack.shared!.context)

            }
        }
        
    }
}
