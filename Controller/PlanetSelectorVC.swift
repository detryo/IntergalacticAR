//
//  PlanetSelectorVC.swift
//  Intergalactic Fun
//
//  Created by Cristian Sedano Arenas on 05/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class PlanetSelectorVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var planet = PlanetsSystem()
    var planetToPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

extension PlanetSelectorVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planet.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.planetCell, for: indexPath) as? PlanetCell {
            
            cell.configureCell(planet: planet.planets[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 210
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        planetToPass = planet.planets[indexPath.row].title
        performSegue(withIdentifier: Segue.toPlanet, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let planetVC = segue.destination as? PlanetViewVC {
            
            planetVC.planet = planetToPass
        }
    }
}
