//
//  MoreInfoCollectionCell.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 08/06/21.
//

import UIKit

class MoreInfoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var nib : UINib{
        UINib(nibName: identifier, bundle: Bundle.main)
    }
    static var identifier : String{
        String(describing: self)
    }
}
