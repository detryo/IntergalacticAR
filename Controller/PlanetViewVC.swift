//
//  ViewController.swift
//  Intergalactic Fun
//
//  Created by Cristian Sedano Arenas on 05/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlanetViewVC: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var planetName: String!
    let baseNote = SCNNode()
    let planetNote = SCNNode()
    let textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        addBaseNode()
        addPlanet()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        sceneView.addGestureRecognizer(gesture)
        
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == .right {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func addBaseNode() {
        
        let baseLocation = SCNVector3(0.0, 0.0, -1.0)
        baseNote.position = baseLocation
        sceneView.scene.rootNode.addChildNode(baseNote)
    }
    
    func addPlanet() {
        
        let planet = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: planetName)
        planet.materials = [material]
        planetNote.geometry = planet
        baseNote.addChildNode(planetNote)
        
        let planetRotate = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 25)
        let repeatRotate = SCNAction.repeatForever(planetRotate)
        planetNote.runAction(repeatRotate)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
}
