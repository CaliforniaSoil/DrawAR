//
//  ViewController.swift
//  DrawAR
//
//  Created by Admin on 1/14/18.
//  Copyright © 2018 Jason Lee. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var draw: UIButton!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var shapeSlider: UISlider!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    var size: CGFloat!
    var shape: SCNNode!
    var shapeNodes: Array<SCNNode> = []
    var count: Int = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.delegate = self
        self.colorSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        self.sizeSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        self.shapeSlider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTapped = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTapped)
        let hitTest = sceneViewTapped.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("Did not touch node")
        } else {
            print(shapeNodes)
        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let cameraPosition = orientation + location
        
        DispatchQueue.main.async {
            
            if self.sizeSlider.value <= 1 {
                self.size = 0.01
            } else if self.sizeSlider.value <= 2 && self.sizeSlider.value > 1 {
                self.size = 0.02
            } else if self.sizeSlider.value <= 3 && self.sizeSlider.value > 2 {
                self.size = 0.03
            } else if self.sizeSlider.value <= 4 && self.sizeSlider.value > 3 {
                self.size = 0.04
            } else if self.sizeSlider.value <= 5 && self.sizeSlider.value > 4 {
                self.size = 0.05
            } else if self.sizeSlider.value <= 6 && self.sizeSlider.value > 5 {
                self.size = 0.06
            } else if self.sizeSlider.value <= 7 && self.sizeSlider.value > 6 {
                self.size = 0.07
            } else if self.sizeSlider.value <= 8 && self.sizeSlider.value > 7 {
                self.size = 0.08
            } else if self.sizeSlider.value <= 9 && self.sizeSlider.value > 8 {
                self.size = 0.09
            } else if self.sizeSlider.value <= 10 && self.sizeSlider.value > 9 {
                self.size = 0.10
            } else {return}
            
            
            if self.shapeSlider.value <= 1 {
                self.shape = SCNNode(geometry: SCNSphere(radius: self.size))
            } else if self.shapeSlider.value <= 2 && self.shapeSlider.value > 1 {
                self.shape = SCNNode(geometry: SCNBox(width: self.size, height: self.size, length: self.size, chamferRadius: 0))
            } else if self.shapeSlider.value <= 3 && self.shapeSlider.value > 2 {
                self.shape = SCNNode(geometry: SCNPyramid(width: self.size, height: self.size, length: self.size))
            } else if self.shapeSlider.value <= 4 && self.shapeSlider.value > 3 {
                self.shape = SCNNode(geometry: SCNCylinder(radius: self.size, height: self.size))
            } else if self.shapeSlider.value <= 5 && self.shapeSlider.value > 4 {
                self.shape = SCNNode(geometry: SCNCone(topRadius: 0, bottomRadius: self.size, height: self.size))
            } else {return}
            
            self.shape.position = cameraPosition
            
            if self.colorSlider.value <= 1 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                self.colorLabel.text = "Red"
                self.colorLabel.textColor = UIColor.red
            } else if self.colorSlider.value <= 2 && self.colorSlider.value > 1 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
                self.colorLabel.text = "Orange"
                self.colorLabel.textColor = UIColor.orange
            } else if self.colorSlider.value <= 3 && self.colorSlider.value > 2 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
                self.colorLabel.text = "Yellow"
                self.colorLabel.textColor = UIColor.yellow
            } else if self.colorSlider.value <= 4 && self.colorSlider.value > 3 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.green
                self.colorLabel.text = "Green"
                self.colorLabel.textColor = UIColor.green
            } else if self.colorSlider.value <= 5 && self.colorSlider.value > 4 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                self.colorLabel.text = "Blue"
                self.colorLabel.textColor = UIColor.blue
            } else if self.colorSlider.value <= 6 && self.colorSlider.value > 5 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
                self.colorLabel.text = "Purple"
                self.colorLabel.textColor = UIColor.purple
            } else if self.colorSlider.value <= 7 && self.colorSlider.value > 6 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.magenta
                self.colorLabel.text = "Magenta"
                self.colorLabel.textColor = UIColor.magenta
            } else if self.colorSlider.value <= 8 && self.colorSlider.value > 7 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
                self.colorLabel.text = "Cyan"
                self.colorLabel.textColor = UIColor.cyan
            } else if self.colorSlider.value <= 9 && self.colorSlider.value > 8 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.white
                self.colorLabel.text = "White"
                self.colorLabel.textColor = UIColor.white
            } else if self.colorSlider.value <= 10 && self.colorSlider.value > 9 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGray
                self.colorLabel.text = "Light Gray"
                self.colorLabel.textColor = UIColor.lightGray
            } else if self.colorSlider.value <= 11 && self.colorSlider.value > 10 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
                self.colorLabel.text = "Gray"
                self.colorLabel.textColor = UIColor.gray
            } else if self.colorSlider.value <= 12 && self.colorSlider.value > 11 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.darkGray
                self.colorLabel.text = "Dark Gray"
                self.colorLabel.textColor = UIColor.darkGray
            } else if self.colorSlider.value <= 13 && self.colorSlider.value > 12 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.black
                self.colorLabel.text = "Black"
                self.colorLabel.textColor = UIColor.black
            } else if self.colorSlider.value <= 14 && self.colorSlider.value > 13 {
                self.shape.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
                self.colorLabel.text = "Brown"
                self.colorLabel.textColor = UIColor.brown
            } else {return}
            
            
            
        if self.draw.isHighlighted {
            
            self.shape.name = String(self.count)
            self.shapeNodes.append(self.shape)
            self.sceneView.scene.rootNode.addChildNode(self.shape)
            
            self.count += 1
            print(self.count)
            print(self.shape)
            
        } else {
            
            let guide = self.shape
            guide?.name = "guide"
            guide?.position = cameraPosition
            self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                if node.name == "guide" {
                    node.removeFromParentNode()
                }
            })
            
            self.sceneView.scene.rootNode.addChildNode(guide!)
            guide?.geometry?.firstMaterial?.diffuse.contents = self.colorLabel.textColor
        }
            
        self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
            if self.clear.isHighlighted {
                node.removeFromParentNode()
            }
        })
        }
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

