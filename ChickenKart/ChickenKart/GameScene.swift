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
    var secondColumn3Grass = SKSpriteNode(imageNamed: "2pt3")

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
        return Double(secondColumn1GrassOffsetY - secondColumn1Grass.size.height/2 - secondColumn2Road.size.height/2)
    }()
    
    lazy var secondColumn3GrassOffsetY: Double = {
        return Double(secondColumn2RoadOffsetY - secondColumn2Road.size.height/2 - secondColumn3Grass.size.height/2)
    }()
    
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        if !motionEnabled {
            setupVirtualController()
        }
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        

        let grassBodiesArray = [firstColumn1Grass, secondColumn1Grass]
        
        for body in grassBodiesArray {
            if playerSprite.intersects(body) {
                print("colisao")
            }
        }
            moveMap()
            
            
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
            
            self.addChild(mapNode)
            
            getInput()
            
            
            
            mapNode.position = CGPoint(x: frame.midX, y: frame.midY)
            
            
            circuitNode = SKSpriteNode(color: .red, size: .init(width: 144, height: 96))
            circuitNode.name = "circuit"
            
            
            addScenario()
            
            
            playerSprite = SKSpriteNode(color: .blue, size: .init(width: 10, height: 10))
            playerSprite.name = "player"
            
            
            mapNode.addChild(circuitNode)
            circuitNode.setScale(CGFloat(5))

            
            mapNode.addChild(playerSprite)
            
            mapNode.xRotation = 1
            
        }
    
    func addScenario() {
        
        
        //primeira coluna
        firstColumn1Grass.position = CGPoint(x: firstColumnOffsetX, y: firstColumnOffsetY)
        circuitNode.addChild(firstColumn1Grass)
        
        //segunda coluna
        secondColumn1Grass.position = CGPoint(x: secondColumnOffsetX,
                                              y: secondColumn1GrassOffsetY)
        circuitNode.addChild(secondColumn1Grass)
        
        secondColumn2Road.position = CGPoint(x: secondColumnOffsetX,
                                             y: secondColumn2RoadOffsetY)
        
        circuitNode.addChild(secondColumn2Road)
        
        secondColumn3Grass.position = CGPoint(x: secondColumnOffsetX,
                                              y: secondColumn3GrassOffsetY)
        circuitNode.addChild(secondColumn3Grass)
        
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
