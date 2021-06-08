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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CityInformationCell.nib, forCellReuseIdentifier: CityInformationCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
extension ManageLocationViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityInformationCell.identifier) as? CityInformationCell {
            cell.place.text = "Chennai"
            cell.temp.text = "28 C"
            return cell
        }
        return UITableViewCell()
    }
    
    
}
