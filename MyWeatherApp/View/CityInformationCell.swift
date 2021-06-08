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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    static var identifier : String{
        String(describing: self)
    }
    static var nib : UINib{
        UINib(nibName: identifier, bundle: Bundle.main)
    }
    
}
