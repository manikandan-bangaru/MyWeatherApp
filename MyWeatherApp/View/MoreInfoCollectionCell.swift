//
//  MoreInfoCollectionCell.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 08/06/21.
//

import UIKit

enum MoreWeatherType{
    case windSpeed
    case humidity
    case visibility
    case pressure
}

class MoreInfoData{
    var type : MoreWeatherType
    var value : String
    init(type : MoreWeatherType , value : String )
    {
        self.type = type
        self.value = value
    }
}
class MoreInfoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var moreinfoData : MoreInfoData?{
        didSet{
            guard let moreinfoData = moreinfoData else {
                return
            }
            var imageName = ""
            switch moreinfoData.type {
           
            case .windSpeed:
                imageName = "wind"
            case .humidity:
                imageName = "drop"
            case .visibility:
                imageName = "eye"
            case .pressure:
                imageName = "speedometer"
            }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(systemName: imageName)
                self.label.text = moreinfoData.value
            }
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 20
        self.contentView.backgroundColor = Constants.viewbgColor
    }

    static var nib : UINib{
        UINib(nibName: identifier, bundle: Bundle.main)
    }
    static var identifier : String{
        String(describing: self)
    }
}
