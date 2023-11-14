//
//  GameViewController.swift
//  scenekit-demo-macos
//
//  Created by Stefan Pettersson on 2023-11-14.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController, SCNSceneRendererDelegate {

    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var spawnTime: TimeInterval = 0

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if time > spawnTime {
            spawnShape()
            spawnTime = time + TimeInterval(1.0)
        }

        cleanScene()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupScene()
        // setupCamera()
        setupClickRecognizer()
    }

    @objc
    func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        spawnShape()
    }

    func setupView() {
        scnView = (self.view as! SCNView)

        scnView.delegate = self

        scnView.isPlaying = true
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
    }

    func setupScene() {
        scnScene = SCNScene(named: "SceneKit Asset Catalog.scnassets/SceneKit Scene.scn")
        scnView.scene = scnScene

        scnScene.background.contents = NSColor.blue
    }

    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 5, z: -10)
        scnScene.rootNode.addChildNode(cameraNode)
    }

    func setupClickRecognizer() {
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        var gestureRecognizers = scnView.gestureRecognizers
        gestureRecognizers.insert(clickGesture, at: 0)
        scnView.gestureRecognizers = gestureRecognizers
    }

    func spawnShape() {
        var geometry: SCNGeometry

        switch ShapeType.random() {
        case ShapeType.Sphere:
            geometry = SCNSphere(radius: 1.0)
            break
        case ShapeType.Pyramid:
            geometry = SCNPyramid(width: 1.0, height: 1.0, length: 1.0)
            break
        case ShapeType.Torus:
            geometry = SCNTorus(ringRadius: 1.0, pipeRadius: 0.6)
            break
        case ShapeType.Capsule:
            geometry = SCNCapsule(capRadius: 0.5, height: 1.0)
            break
        case ShapeType.Cylinder:
            geometry = SCNCylinder(radius: 0.5, height: 1.5)
            break
        case ShapeType.Cone:
            geometry = SCNCone(topRadius: 0, bottomRadius: 0.5, height: 1.5)
            break
        case ShapeType.Tube:
            geometry = SCNTube(innerRadius: 0.5, outerRadius: 1.0, height: 1.5)
            break
        default:
            geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        }

        geometry.materials.first?.diffuse.contents = Utils.randomColor()

        let geometryNode = SCNNode(geometry: geometry)

        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)

        let randomX = Float.random(in: -2...2)
        let randomY = Float.random(in: 5...8)

        let force = SCNVector3(x: CGFloat(randomX), y: CGFloat(randomY), z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)

        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)

        scnScene.rootNode.addChildNode(geometryNode)
    }

    func cleanScene() {
      for node in scnScene.rootNode.childNodes {
          if node.presentation.position.y < -2 {
          node.removeFromParentNode()
        }
      }
    }
}
