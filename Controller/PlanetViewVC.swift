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
        addText()
        addShip()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        sceneView.addGestureRecognizer(gesture)
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
    
    func addText() {
        
        let text = SCNText(string: planetName.capitalized, extrusionDepth: 1)
        text.font = UIFont(name: "futura", size: 16)
        text.flatness = 0
        
        let scaleFactor = 0.1 / text.font.pointSize
        textNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        textNode.geometry = text
        
        let max = textNode.boundingBox.max.x
        let min = textNode.boundingBox.min.x
        let midpoint = -( (max - min) / 2 + min) * Float(scaleFactor)
        
        textNode.position = SCNVector3(midpoint, 0.35, 0)
        baseNote.addChildNode(textNode)
    }
    
    func addShip() {
        
        let orbitAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 6)
        let repeatOrbit = SCNAction.repeatForever(orbitAction)
        
        let wait = SCNAction.wait(duration: 1)
        
        let shipUpAction = SCNAction.move(to: SCNVector3(-0.35, 0.2, 0), duration: 2)
        shipUpAction.timingMode = .easeInEaseOut
        
        let shipDownAction = SCNAction.move(to: SCNVector3(-0.35, -0.2, 0), duration: 2)
        shipDownAction.timingMode = .easeInEaseOut
        
        let upDown = SCNAction.sequence([shipUpAction, wait, shipDownAction])
        let repeatUpDown = SCNAction.repeatForever(upDown)
        
        let pitchUpAction = SCNAction.rotateTo(x: -0.3, y: 0.0, z: -0.17, duration: 1)
        pitchUpAction.timingMode = .easeInEaseOut
        let levelOff = SCNAction.rotateTo(x: 0.0, y: 0.0, z: 0.0, duration: 1)
        let shipReversePitch = SCNAction.rotateTo(x: 0.3, y: 0.0, z: 0.17, duration: 1)
        shipReversePitch.timingMode = .easeInEaseOut
        let pitchUpDown = SCNAction.sequence([pitchUpAction, levelOff, wait, shipReversePitch, levelOff, wait])
        let repeatPitch = SCNAction.repeatForever(pitchUpDown)
        
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")
            
        if let shipNode = scene?.rootNode.childNode(withName: "ship", recursively: true) {
            shipNode.scale = SCNVector3(0.2, 0.2, 0.2)
            shipNode.position = SCNVector3(-0.35, 0, 0)
            
            let rotateNode = SCNNode()
            baseNote.addChildNode(rotateNode)
            rotateNode.addChildNode(shipNode)
            rotateNode.runAction(repeatOrbit)
            
            rotateNode.runAction(repeatPitch)
            
            shipNode.runAction(repeatUpDown)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
}
