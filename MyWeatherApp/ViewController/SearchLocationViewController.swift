//
//  SearchLocationViewController.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation
import UIKit
class SearchLocationViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    var weatherDataSet : [WeatherViewModal]?{
        
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.barTintColor = Constants.viewbgColor
        self.searchBar.barTintColor = Constants.viewbgColor
        self.view.backgroundColor = Constants.viewbgColor
        self.tableView.backgroundColor = Constants.viewbgColor
        self.searchBar.backgroundColor = Constants.viewbgColor
        self.searchBar.backgroundImage = nil
        self.tableView.separatorStyle = .none
        
        self.navBar.topItem?.title = Constants.searchVCTitle
        searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CityInformationCell.nib, forCellReuseIdentifier: CityInformationCell.identifier)
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
        }
        self.searchBar.becomeFirstResponder()
        self.tableView.allowsSelection = false
    }
    
    
}
extension SearchLocationViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDataSet?.count ?? 0
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityInformationCell.identifier) as? CityInformationCell{
          
            cell.weatherInfo = self.weatherDataSet?[indexPath.row]
            cell.parentVC = self
            return cell
        }
        return UITableViewCell()
    }
}
extension SearchLocationViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchCityParams = WeatherRequestParams.SearchCityParamBuilder()
            .set(cityName: searchText)
            .build()
            
        WeatherAPIClient.shared.searchCity(apiURLComponents: searchCityParams) { response, error in
            
            guard error == nil else{
                return
            }
            if let response = response as? SearchCityResponse{
                
                
                var weathermodals = [WeatherViewModal]()
                if let weatherList = response.list{
                    for weatherResponse in weatherList{
                        
                        weathermodals.append(WeatherViewModal(response: weatherResponse))
                    }
                }
                DispatchQueue.main.async {
                    self.weatherDataSet = weathermodals
                }
            }
        }
        
    }
}
