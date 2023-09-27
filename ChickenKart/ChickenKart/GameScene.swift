//
//  GameScene.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SpriteKit
import SwiftUI
import GameController
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKTransformNode()
    
    var playerSprite = SKSpriteNode()
    
    var circuitNode = SKSpriteNode()
    
    var vectorGravity = CGVector(dx: 0, dy: -2.0)
    
    var virtualController: GCVirtualController?
        
    var angle: Double = 0
    
    var isSpeedPressed: Bool = false
    
    var isTurningRight: Bool = false
    
    var isTurningLeft: Bool = false
    
    var isUsingThumbstick: Bool = false
    
    var thumbstickValue: Double = 0.0
    
    var motionManager = MotionManager()
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setupVirtualController()

    }
    
    override func update(_ currentTime: TimeInterval) {
        motionBackground()
    }

    
    override func didMove(to view: SKView) {
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        getInput()

        player.position = CGPoint(x: frame.midX, y: frame.midY)
        
        circuitNode = SKSpriteNode(color: .brown, size: .init(width: 520, height: 450))
        circuitNode.anchorPoint = CGPoint(x: 0, y: 0)
        
        let ground = SKSpriteNode(imageNamed: "circuitpt1")
        
        ground.anchorPoint = CGPoint(x: 0.5, y: 0)
        ground.position = CGPoint(x: circuitNode.frame.midX, y: circuitNode.frame.minY)
        ground.name = "ground"

        circuitNode.addChild(ground)

        let ceil = SKSpriteNode(imageNamed: "circuitpt2")
        ceil.anchorPoint = CGPoint(x: 0, y: 1)
        ceil.position = CGPoint(x: circuitNode.frame.minX, y: circuitNode.frame.maxY)
        ceil.name = "ceil"

        circuitNode.addChild(ceil)

        circuitNode.name = "circuit"
        
        player.addChild(circuitNode)

        let playerSprite = SKSpriteNode(color: .clear, size: .init(width: 10, height: 10))
        playerSprite.name = "player"
                
        player.addChild(playerSprite)
        
        player.xRotation = Angle(degrees: 85).radians
        
        player.setScale(CGFloat(15))
    }
    
    func motionBackground() {
        self.angle = motionManager.rotationRateValue.z * 5
        self.player.zRotation = CGFloat(Angle(degrees: self.angle).radians)
        if Int(motionManager.rotationRateValue.y) > 1 {
            self.circuitNode.position.x += sin(Angle(degrees: self.angle).radians)
            self.circuitNode.position.y -= cos(Angle(degrees: self.angle).radians)
        } else if Int(motionManager.rotationRateValue.y) < 0 {
            self.circuitNode.position.x -= sin(Angle(degrees: self.angle).radians)
            self.circuitNode.position.y += cos(Angle(degrees: self.angle).radians)
        }
        
    }
    
    
    func setupVirtualController() {
        let virtualControllerConfig = GCVirtualController.Configuration()
        virtualControllerConfig.elements = [GCInputButtonA]
        
        virtualController = GCVirtualController(configuration: virtualControllerConfig)
        
        virtualController!.connect()
        
    }
    
    func getInput() {
        
        guard let buttons = virtualController!.controller?.extendedGamepad else { return }
        
        let speedButton = buttons.buttonA

        speedButton.pressedChangedHandler = { button, value, pressed in
            if pressed {
                self.isSpeedPressed = true
                print("speed Pressed")
            } else {
                print("speed Unpressed")
                self.isSpeedPressed = false

            }
            
        }
        
    }
    
}
