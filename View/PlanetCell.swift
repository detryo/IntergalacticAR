//
//  PlanetCell.swift
//  Intergalactic Fun
//
//  Created by Cristian Sedano Arenas on 05/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {
    
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        planetImage.layer.cornerRadius = 10
    }

    func configureCell(planet: Planets) {
        planetImage.image = UIImage(named: planet.imageName)
        planetTitle.text = planet.title
    }
}
