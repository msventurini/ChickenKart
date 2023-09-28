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
    
    var ceil = SKSpriteNode()
    
    var ground = SKSpriteNode()

    var circuitNode = SKSpriteNode()
    
    var circuitShape = SKShapeNode()
    
    var vectorGravity = CGVector(dx: 0, dy: -2.0)
    
    var virtualController: GCVirtualController?
    
    var angle: Double = 0
    
    var isSpeedPressed: Bool = false
    
    var isTurningRight: Bool = false
    
    var isTurningLeft: Bool = false
    
    var isUsingThumbstick: Bool = false
    
    var thumbstickValue: Double = 0.0
    
    var isColiding: Bool = false
    
    var motionManager = MotionManager()
    
    let outerPath = CGMutablePath()
    let innerPath = CGMutablePath()

    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setupVirtualController()
        
        let width = 200.0
        let height = 200.0
        outerPath.move(to: CGPoint(x: 0.10688*width, y: 0.9985*height))
        outerPath.addLine(to: CGPoint(x: 0.88991*width, y: 0.9985*height))
        outerPath.addLine(to: CGPoint(x: 0.9555*width, y: 0.92929*height))
        outerPath.addLine(to: CGPoint(x: 0.9555*width, y: 0.80642*height))
        outerPath.addLine(to: CGPoint(x: 0.79862*width, y: 0.6319*height))
        outerPath.addLine(to: CGPoint(x: 0.79862*width, y: 0.34704*height))
        outerPath.addLine(to: CGPoint(x: 0.85826*width, y: 0.28987*height))
        outerPath.addLine(to: CGPoint(x: 0.9211*width, y: 0.28987*height))
        outerPath.addLine(to: CGPoint(x: 0.99862*width, y: 0.20261*height))
        outerPath.addLine(to: CGPoint(x: 0.99862*width, y: 0.12889*height))
        outerPath.addLine(to: CGPoint(x: 0.99128*width, y: 0.11284*height))
        outerPath.addLine(to: CGPoint(x: 0.97339*width, y: 0.08024*height))
        outerPath.addLine(to: CGPoint(x: 0.94954*width, y: 0.05968*height))
        outerPath.addLine(to: CGPoint(x: 0.9289*width, y: 0.05065*height))
        outerPath.addLine(to: CGPoint(x: 0.91835*width, y: 0.05065*height))
        outerPath.addLine(to: CGPoint(x: 0.91376*width, y: 0.05968*height))
        outerPath.addLine(to: CGPoint(x: 0.90275*width, y: 0.05968*height))
        outerPath.addLine(to: CGPoint(x: 0.86789*width, y: 0.0988*height))
        outerPath.addLine(to: CGPoint(x: 0.85826*width, y: 0.0988*height))
        outerPath.addLine(to: CGPoint(x: 0.84495*width, y: 0.08024*height))
        outerPath.addLine(to: CGPoint(x: 0.83211*width, y: 0.05416*height))
        outerPath.addLine(to: CGPoint(x: 0.81697*width, y: 0.01805*height))
        outerPath.addLine(to: CGPoint(x: 0.8055*width, y: 0.00201*height))
        outerPath.addLine(to: CGPoint(x: 0.63945*width, y: 0.00201*height))
        outerPath.addLine(to: CGPoint(x: 0.56927*width, y: 0.08024*height))
        outerPath.addLine(to: CGPoint(x: 0.56927*width, y: 0.29789*height))
        outerPath.addLine(to: CGPoint(x: 0.61284*width, y: 0.34704*height))
        outerPath.addLine(to: CGPoint(x: 0.61284*width, y: 0.41374*height))
        outerPath.addLine(to: CGPoint(x: 0.60413*width, y: 0.41374*height))
        outerPath.addLine(to: CGPoint(x: 0.53532*width, y: 0.48997*height))
        outerPath.addLine(to: CGPoint(x: 0.44771*width, y: 0.48997*height))
        outerPath.addLine(to: CGPoint(x: 0.35872*width, y: 0.58576*height))
        outerPath.addLine(to: CGPoint(x: 0.35872*width, y: 0.1675*height))
        outerPath.addLine(to: CGPoint(x: 0.3344*width, y: 0.13691*height))
        outerPath.addLine(to: CGPoint(x: 0.30826*width, y: 0.10782*height))
        outerPath.addLine(to: CGPoint(x: 0.29862*width, y: 0.10782*height))
        outerPath.addLine(to: CGPoint(x: 0.28211*width, y: 0.08927*height))
        outerPath.addLine(to: CGPoint(x: 0.22018*width, y: 0.08927*height))
        outerPath.addLine(to: CGPoint(x: 0.17661*width, y: 0.13691*height))
        outerPath.addLine(to: CGPoint(x: 0.17661*width, y: 0.33701*height))
        outerPath.addLine(to: CGPoint(x: 0.15872*width, y: 0.35707*height))
        outerPath.addLine(to: CGPoint(x: 0.07064*width, y: 0.35707*height))
        outerPath.addLine(to: CGPoint(x: 0.01835*width, y: 0.41575*height))
        outerPath.addLine(to: CGPoint(x: 0.00183*width, y: 0.67252*height))
        outerPath.addLine(to: CGPoint(x: 0.00183*width, y: 0.89017*height))
        outerPath.addLine(to: CGPoint(x: 0.02752*width, y: 0.93029*height))
        outerPath.addLine(to: CGPoint(x: 0.0555*width, y: 0.95988*height))
        outerPath.addLine(to: CGPoint(x: 0.10688*width, y: 0.9985*height))
        outerPath.closeSubpath()
        
        innerPath.move(to: CGPoint(x: 0.26558*width, y: 0.64847*height))
        innerPath.addLine(to: CGPoint(x: 0.26558*width, y: 0.13439*height))
        innerPath.addLine(to: CGPoint(x: 0.22809*width, y: 0.08803*height))
        innerPath.addLine(to: CGPoint(x: 0.21489*width, y: 0.08803*height))
        innerPath.addLine(to: CGPoint(x: 0.20433*width, y: 0.10153*height))
        innerPath.addLine(to: CGPoint(x: 0.20433*width, y: 0.33451*height))
        innerPath.addLine(to: CGPoint(x: 0.13305*width, y: 0.41491*height))
        innerPath.addLine(to: CGPoint(x: 0.04541*width, y: 0.41491*height))
        innerPath.addLine(to: CGPoint(x: 0.0227*width, y: 0.43545*height))
        innerPath.addLine(to: CGPoint(x: 0.00211*width, y: 0.76408*height))
        innerPath.addLine(to: CGPoint(x: 0.00211*width, y: 0.94014*height))
        innerPath.addLine(to: CGPoint(x: 0.05385*width, y: 0.99765*height))
        innerPath.addLine(to: CGPoint(x: 0.91816*width, y: 0.99765*height))
        innerPath.addLine(to: CGPoint(x: 0.94087*width, y: 0.97124*height))
        innerPath.addLine(to: CGPoint(x: 0.94087*width, y: 0.89671*height))
        innerPath.addLine(to: CGPoint(x: 0.7698*width, y: 0.70775*height))
        innerPath.addLine(to: CGPoint(x: 0.7698*width, y: 0.29225*height))
        innerPath.addLine(to: CGPoint(x: 0.79989*width, y: 0.27406*height))
        innerPath.addLine(to: CGPoint(x: 0.83105*width, y: 0.24531*height))
        innerPath.addLine(to: CGPoint(x: 0.86589*width, y: 0.19308*height))
        innerPath.addLine(to: CGPoint(x: 0.94087*width, y: 0.19308*height))
        innerPath.addLine(to: CGPoint(x: 0.98733*width, y: 0.16549*height))
        innerPath.addLine(to: CGPoint(x: 0.99842*width, y: 0.13439*height))
        innerPath.addLine(to: CGPoint(x: 0.99842*width, y: 0.05927*height))
        innerPath.addLine(to: CGPoint(x: 0.98733*width, y: 0.05927*height))
        innerPath.addLine(to: CGPoint(x: 0.94087*width, y: 0.11209*height))
        innerPath.addLine(to: CGPoint(x: 0.86589*width, y: 0.11209*height))
        innerPath.addLine(to: CGPoint(x: 0.83105*width, y: 0.04519*height))
        innerPath.addLine(to: CGPoint(x: 0.79989*width, y: 0.00235*height))
        innerPath.addLine(to: CGPoint(x: 0.68743*width, y: 0.00235*height))
        innerPath.addLine(to: CGPoint(x: 0.64889*width, y: 0.05927*height))
        innerPath.addLine(to: CGPoint(x: 0.64889*width, y: 0.24531*height))
        innerPath.addLine(to: CGPoint(x: 0.68743*width, y: 0.29225*height))
        innerPath.addLine(to: CGPoint(x: 0.68743*width, y: 0.43545*height))
        innerPath.addLine(to: CGPoint(x: 0.55808*width, y: 0.56984*height))
        innerPath.addLine(to: CGPoint(x: 0.45565*width, y: 0.56984*height))
        innerPath.addLine(to: CGPoint(x: 0.3886*width, y: 0.64847*height))
        innerPath.addLine(to: CGPoint(x: 0.37012*width, y: 0.64847*height))
        innerPath.addLine(to: CGPoint(x: 0.33685*width, y: 0.69425*height))
        innerPath.addLine(to: CGPoint(x: 0.30306*width, y: 0.69425*height))
        innerPath.addLine(to: CGPoint(x: 0.26558*width, y: 0.64847*height))
        innerPath.closeSubpath()
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
                
        if ground.intersects(playerSprite) {
            self.circuitNode.position.x -= sin(Angle(degrees: self.angle).radians) * 5
            self.circuitNode.position.y += cos(Angle(degrees: self.angle).radians) * 5
            motionBackground()

        } else if ceil.intersects(playerSprite) {

            self.circuitNode.position.x -= sin(Angle(degrees: self.angle).radians) * 5
            self.circuitNode.position.y += cos(Angle(degrees: self.angle).radians) * 5
            motionBackground()
            
        } else {
            motionBackground()

        }

        
    }
    
    
    override func didMove(to view: SKView) {
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        getInput()
        
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        
        circuitNode = SKSpriteNode(color: .brown, size: .init(width: 520, height: 450))
        circuitNode.anchorPoint = CGPoint(x: 0, y: 0)
        
        ground = SKSpriteNode(imageNamed: "circuitpt1")
        
        ground.anchorPoint = CGPoint(x: 0.5, y: 0)
        ground.position = CGPoint(x: circuitNode.frame.midX, y: circuitNode.frame.minY)
        ground.name = "ground"
        
        circuitNode.addChild(ground)
        
        ceil = SKSpriteNode(imageNamed: "circuitpt2")
        ceil.anchorPoint = CGPoint(x: 0, y: 1)
        ceil.position = CGPoint(x: circuitNode.frame.minX, y: circuitNode.frame.maxY)
        ceil.name = "ceil"
        
        circuitNode.addChild(ceil)
        
        circuitNode.name = "circuit"
        
        player.addChild(circuitNode)
        
        playerSprite = SKSpriteNode(color: .black, size: .init(width: 10, height: 10))
        playerSprite.name = "player"
        
        player.addChild(playerSprite)
        
//        player.xRotation = Angle(degrees: 85).radians
        
        player.setScale(CGFloat(5))
        
        
        
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
