//
//  ManageLocationViewController.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation
import UIKit
class ManageLocationViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addLocation: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
//    var favCitiesWeatherInfo : [WeatherViewModal]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CityInformationCell.nib, forCellReuseIdentifier: CityInformationCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.view.backgroundColor = Constants.viewbgColor
        self.tableView.backgroundColor = Constants.viewbgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: Notification.RefreshManageCitiesVCNN, object: nil)
    }
    
    @objc func refresh(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}
extension ManageLocationViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CityInfoUtil.shared.getFavCities()?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let select_weather = CityInfoUtil.shared.getFavCities()?[indexPath.row]{
            
            CityInfoUtil.shared.updateCurrentWeatherInfo(weatherModal: select_weather)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityInformationCell.identifier) as? CityInformationCell {
            cell.place.text = CityInfoUtil.shared.getFavCities()?[indexPath.row].getPlace()
            cell.temp.text = (CityInfoUtil.shared.getFavCities()?[indexPath.row].getCurrentTemp() ?? "-") + " C"
            cell.addButton.isHidden = true
            return cell
        }
        return UITableViewCell()
    }
    
    
}
