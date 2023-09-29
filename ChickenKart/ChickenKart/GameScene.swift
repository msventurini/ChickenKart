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
    
    
    
    var mapNode = SKTransformNode()
    
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
    
    var isBreakPressed: Bool = false
    
    
    var isTurningRight: Bool = false
    
    var isTurningLeft: Bool = false
    
    var isUsingThumbstick: Bool = false
    
    var thumbstickValue: Double = 0.0
    
    var isColiding: Bool = false
    
    var motionManager = MotionManager()
    
    let outerPath = CGMutablePath()
    let innerPath = CGMutablePath()
    
    //desestanciar isso
    
    //gramas
    var firstColumn1Grass = SKSpriteNode(imageNamed: "1pt1")
    var secondColumn1Grass = SKSpriteNode(imageNamed: "2pt1")
    
    //estradas
    var secondColumn2Road = SKSpriteNode(imageNamed: "2pt2")
    
    
    
    let motionEnabled: Bool = false
    
    //valores constantes de offset em X

    lazy var firstColumnOffsetX: Double = {
        return Double(-self.circuitNode.size.width/2 + firstColumn1Grass.size.width/2)
    }()
    
    lazy var secondColumnOffsetX: Double = {
        return Double(-circuitNode.size.width/2 + firstColumn1Grass.size.width + secondColumn1Grass.size.width/2)
    }()
    
    //valores constantes de offset em Y
    lazy var firstColumnOffsetY: Double = {
        return Double(0)
    }()
    
    
    lazy var secondColumn1GrassOffsetY: Double = {
        return Double(circuitNode.size.height/2 - secondColumn1Grass.size.height/2)
    }()
    
    lazy var secondColumn2RoadOffsetY: Double = {
        return Double(circuitNode.size.height/2 - secondColumn1Grass.size.height - secondColumn2Road.size.height/2)
    }()
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        if !motionEnabled {
            setupVirtualController()
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if firstColumn1Grass.intersects(playerSprite) {
            self.circuitNode.position.x -= sin(Angle(degrees: self.angle).radians) * 5 * (isBreakPressed ? -5 : 1)
            self.circuitNode.position.y += cos(Angle(degrees: self.angle).radians) * 5 * (isBreakPressed ? -5 : 1)
            moveMap()
            
            //        } else if ceil.intersects(playerSprite) {
            //
            //            self.circuitNode.position.x -= sin(Angle(degrees: self.angle).radians) * 5
            //            self.circuitNode.position.y += cos(Angle(degrees: self.angle).radians) * 5
            //            motionBackground()
            
        } else {
            
            moveMap()
            
        }
        
        
        
    }
    
    func moveMap() {
        if motionEnabled {
            motionBackground()
        } else {
            if isSpeedPressed {
                self.circuitNode.position.x +=  sin(Angle(degrees: self.angle).radians)
                self.circuitNode.position.y -=  cos(Angle(degrees: self.angle).radians)
            } else if isBreakPressed {
                self.circuitNode.position.x -= sin(Angle(degrees: self.angle).radians)
                self.circuitNode.position.y += cos(Angle(degrees: self.angle).radians)
            }
            
            
            
            if isUsingThumbstick {
                self.angle -= thumbstickValue// - log(abs(thumbstickValue))
                self.mapNode.zRotation = CGFloat(Angle(degrees: self.angle).radians)
                
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        let tam = 25 + 8 + 19 + 9 + 14 + 4 + 5 + 6 + 6 + 7 + 7 + 34
        
        //        mapNode.size = CGSize(width: (tam), height: 96)
        //        mapNode.color = .blue
        
        self.addChild(mapNode)
        
        getInput()
        
        
        
        mapNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        
        circuitNode = SKSpriteNode(color: .red, size: .init(width: 144, height: 96))
        circuitNode.name = "circuit"
        
        
        
        
        mapNode.addChild(circuitNode)
        
        firstColumn1Grass.position = CGPoint(x: firstColumnOffsetX, y: firstColumnOffsetY)
        circuitNode.addChild(firstColumn1Grass)
        
        secondColumn1Grass.position = CGPoint(x: secondColumnOffsetX,
                                              y: secondColumn1GrassOffsetY)
        circuitNode.addChild(secondColumn1Grass)
        
        secondColumn2Road.position = CGPoint(x: secondColumnOffsetX,
                                             y: secondColumn2RoadOffsetY)
        
        circuitNode.addChild(secondColumn2Road)
        
        
        playerSprite = SKSpriteNode(color: .blue, size: .init(width: 10, height: 10))
        playerSprite.name = "player"
        mapNode.addChild(playerSprite)
        
        
        //        self.addChild(player)
        //
        //        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        //        self.physicsWorld.contactDelegate = self
        //
        //        getInput()
        //
        //        player.position = CGPoint(x: frame.midX, y: frame.midY)
        //
        //        circuitNode = SKSpriteNode(color: .clear, size: .init(width: 520, height: 450))
        //        circuitNode.anchorPoint = CGPoint(x: 0, y: 0)
        //        circuitNode.name = "circuit"
        //
        //
        //        ground = SKSpriteNode(imageNamed: "circuitpt1")
        //
        //        ground.anchorPoint = CGPoint(x: 0.5, y: 0)
        //        ground.position = CGPoint(x: circuitNode.frame.midX, y: circuitNode.frame.minY)
        //        ground.name = "ground"
        //
        //        circuitNode.addChild(ground)
        //
        //        ceil = SKSpriteNode(imageNamed: "circuitpt2")
        //        ceil.anchorPoint = CGPoint(x: 0, y: 1)
        //        ceil.position = CGPoint(x: circuitNode.frame.minX, y: circuitNode.frame.maxY)
        //        ceil.name = "ceil"
        //
        //        circuitNode.addChild(ceil)
        //
        //
        //        player.addChild(circuitNode)
        //
        //        playerSprite = SKSpriteNode(color: .black, size: .init(width: 10, height: 10))
        //        playerSprite.name = "player"
        //
        //        player.addChild(playerSprite)
        //
        ////        player.xRotation = Angle(degrees: 85).radians
        //
        //        player.setScale(CGFloat(5))
        
        
        
    }
    
    func motionBackground() {
        self.angle = motionManager.rotationRateValue.z * 5
        self.mapNode.zRotation = CGFloat(Angle(degrees: self.angle).radians)
        
        
        
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
        virtualControllerConfig.elements = [GCInputLeftThumbstick, GCInputButtonA, GCInputButtonB]
        
        virtualController = GCVirtualController(configuration: virtualControllerConfig)
        
        virtualController!.connect()
        
    }
    
    func getInput() {
        
        guard let buttons = virtualController!.controller?.extendedGamepad else { return }
        
        let breakButton = buttons.buttonB
        let speedButton = buttons.buttonA
        let stickXAxis = buttons.leftThumbstick.xAxis
        
        stickXAxis.valueChangedHandler = { button, value in
            
            if value != 0.0 {
                self.isUsingThumbstick = true
                self.thumbstickValue = Double(value)
            } else {
                self.isUsingThumbstick = false
                self.thumbstickValue = Double(0.0)
            }
            
        }
        
        breakButton.pressedChangedHandler = { button, value, pressed in
            
            if pressed {
                self.isBreakPressed = true
                print("break Pressed")
                
                
                
            } else {
                self.isBreakPressed = false
                print("break Pressed")
            }
            
            
        }
        
        speedButton.pressedChangedHandler = { button, value, pressed in
            if pressed {
                self.isSpeedPressed = true
                print("speed Pressed")
            } else {
                self.isSpeedPressed = false
                print("speed Unpressed")
            }
            
        }
        
    }
    
}
