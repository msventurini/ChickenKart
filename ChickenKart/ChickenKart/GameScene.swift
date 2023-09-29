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
    
    var thirdColumn1Grass = SKSpriteNode(imageNamed: "3pt1")
    var thirdColumn5Grass = SKSpriteNode(imageNamed: "3pt5")
    
    //estradas
    var secondColumn2Road = SKSpriteNode(imageNamed: "2pt2")
    
    var thirdColumn2Road = SKSpriteNode(imageNamed: "3pt2")
    var thirdColumn4Road = SKSpriteNode(imageNamed: "3pt4")
    
    //feno
    var thirdColumn3Hay = SKSpriteNode(imageNamed: "3pt3")
    
    // quarta coluna pra frente, organizo depois
    
    var fourthColumn1Grass = SKSpriteNode(imageNamed: "4pt1")
    var fourthColumn2Road = SKSpriteNode(imageNamed: "4pt2")
    var fourthColumn3hay = SKSpriteNode(imageNamed: "4pt3")
    var fourthColumn4Road = SKSpriteNode(imageNamed: "4pt4")
    var fourthColumn5Grass = SKSpriteNode(imageNamed: "4pt5")
    
    var fifthColumn1Grass = SKSpriteNode(imageNamed: "5pt1")
    var fifthColumn2Road = SKSpriteNode(imageNamed: "5pt2")
    var fifthColumn3hay = SKSpriteNode(imageNamed: "5pt3")
    var fifthColumn4Road = SKSpriteNode(imageNamed: "5pt4")
    var fifthColumn5Grass = SKSpriteNode(imageNamed: "5pt5")
    
    let motionEnabled: Bool = false
    
    var sixthColumn1Grass = SKSpriteNode(imageNamed: "6pt1")
    var sixthColumn2Road = SKSpriteNode(imageNamed: "6pt2")
    var sixthColumn3Grass = SKSpriteNode(imageNamed: "6pt3")
    var sixthColumn4Road = SKSpriteNode(imageNamed: "6pt4")
    var sixthColumn5Hay = SKSpriteNode(imageNamed: "6pt5")
    var sixthColumn6Road = SKSpriteNode(imageNamed: "6pt6")
    var sixthColumn7Grass = SKSpriteNode(imageNamed: "6pt7")
    
    var seventhColumn1Grass = SKSpriteNode(imageNamed: "7pt1")
    var seventhColumn2Road = SKSpriteNode(imageNamed: "7pt2")
    var seventhColumn3Hay = SKSpriteNode(imageNamed: "7pt3")
    var seventhColumn4Road = SKSpriteNode(imageNamed: "7pt4")
    var seventhColumn5Hay = SKSpriteNode(imageNamed: "7pt5")
    var seventhColumn6Road = SKSpriteNode(imageNamed: "7pt6")
    var seventhColumn7Grass = SKSpriteNode(imageNamed: "7pt7")

    var eighthColumn1Grass = SKSpriteNode(imageNamed: "8pt1")
    var eighthColumn2Road = SKSpriteNode(imageNamed: "8pt2")
    var eighthColumn3Hay = SKSpriteNode(imageNamed: "8pt3")
    var eighthColumn4Road = SKSpriteNode(imageNamed: "8pt4")
    var eighthColumn5Grass = SKSpriteNode(imageNamed: "8pt5")
    
    var ninthColumn1Grass = SKSpriteNode(imageNamed: "9pt1")
    var ninthColumn2Road = SKSpriteNode(imageNamed: "9pt2")
    var ninthColumn3Hay = SKSpriteNode(imageNamed: "9pt3")
    var ninthColumn4Road = SKSpriteNode(imageNamed: "9pt4")
    var ninthColumn5Hay = SKSpriteNode(imageNamed: "9pt5")
    var ninthColumn6Road = SKSpriteNode(imageNamed: "9pt6")
    var ninthColumn7Grass = SKSpriteNode(imageNamed: "9pt7")
    
    var tenthColumn1Grass = SKSpriteNode(imageNamed: "10pt1")
    var tenthColumn2Road = SKSpriteNode(imageNamed: "10pt2")
    var tenthColumn3Hay = SKSpriteNode(imageNamed: "10pt3")
    var tenthColumn4Road = SKSpriteNode(imageNamed: "10pt4")
    var tenthColumn5Grass = SKSpriteNode(imageNamed: "10pt5")
    var tenthColumn6Road = SKSpriteNode(imageNamed: "10pt6")
    var tenthColumn7Hay = SKSpriteNode(imageNamed: "10pt7")
    var tenthColumn8Road = SKSpriteNode(imageNamed: "10pt8")
    var tenthColumn9Green = SKSpriteNode(imageNamed: "10pt9")
    
    var eleventhColumn1Grass = SKSpriteNode(imageNamed: "11pt1")
    var eleventhColumn2Road = SKSpriteNode(imageNamed: "11pt2")
    var eleventhColumn3Grass = SKSpriteNode(imageNamed: "11pt3")
    var eleventhColumn4Road = SKSpriteNode(imageNamed: "11pt4")
    var eleventhColumn5Grass = SKSpriteNode(imageNamed: "11pt5")
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        if !motionEnabled {
            setupVirtualController()
        }
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
        let grassBodiesArray = [firstColumn1Grass, secondColumn1Grass, secondColumn3Grass]
        
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
        
        let firstColumn: [SKSpriteNode] = [firstColumn1Grass]
        let secondColumn: [SKSpriteNode] = [secondColumn1Grass, secondColumn2Road, secondColumn3Grass]
        let thirdColumn: [SKSpriteNode] = [thirdColumn1Grass, thirdColumn2Road, thirdColumn3Hay, thirdColumn4Road, thirdColumn5Grass]
        let fourthColumn: [SKSpriteNode] = [fourthColumn1Grass, fourthColumn2Road, fourthColumn3hay, fourthColumn4Road, fourthColumn5Grass]
        let fifthColumn: [SKSpriteNode] = [fifthColumn1Grass, fifthColumn2Road, fifthColumn3hay, fifthColumn4Road, fifthColumn5Grass]
        let sixthColumn: [SKSpriteNode] = [sixthColumn1Grass, sixthColumn2Road, sixthColumn3Grass, sixthColumn4Road, sixthColumn5Hay, sixthColumn6Road, sixthColumn7Grass]
        var seventhColumn: [SKSpriteNode] = [seventhColumn1Grass, seventhColumn2Road, seventhColumn3Hay, seventhColumn4Road, seventhColumn5Hay, seventhColumn6Road, seventhColumn7Grass]
        var eighthColumn: [SKSpriteNode] = [eighthColumn1Grass, eighthColumn2Road, eighthColumn3Hay, eighthColumn4Road, eighthColumn5Grass]

        var ninthColumn: [SKSpriteNode] = [ninthColumn1Grass, ninthColumn2Road, ninthColumn3Hay, ninthColumn4Road, ninthColumn5Hay, ninthColumn6Road, ninthColumn7Grass]
        
        var tenthColumn: [SKSpriteNode] = [tenthColumn1Grass, tenthColumn2Road, tenthColumn3Hay, tenthColumn4Road, tenthColumn5Grass, tenthColumn6Road, tenthColumn7Hay, tenthColumn8Road, tenthColumn9Green]
        
        var eleventhColumn: [SKSpriteNode] = [eleventhColumn1Grass, eleventhColumn2Road, eleventhColumn3Grass, eleventhColumn4Road, eleventhColumn5Grass,]
        
        let fullTileMap: [[SKSpriteNode]] = [firstColumn, secondColumn, thirdColumn, fourthColumn, fifthColumn, sixthColumn, seventhColumn, eighthColumn, ninthColumn, tenthColumn, eleventhColumn]
        

        
            
        
        
        //        firstColumn1Grass.position.x = firstColumnOffsetX
        //        SKVStack(inputArray: firstColumn)
        
        for i in stride(from: 0, to: fullTileMap.count, by: 1) {
            
            SKVStack(inputArray: fullTileMap[i])
            
            for j in stride(from: 0, to: fullTileMap[i].count, by: 1) {
                circuitNode.addChild(fullTileMap[i][j])
            }
        }
        
        SKHStack(inputArray: fullTileMap)
        
        
        
        
    }
    
    
    
    func SKVStack(inputArray: [SKSpriteNode]) {
        for index in stride(from: 0, to: inputArray.count, by: 1) {
            if index == 0 {
                inputArray[index].position.y = circuitNode.size.height/2 - inputArray[index].size.height/2
            } else {
                inputArray[index].position.y = (inputArray[index - 1].position.y) - (inputArray[index - 1].size.height/2) - inputArray[index].size.height/2
                
            }
        }
    }
    
    func SKHStack(inputArray: [[SKSpriteNode]]) {
        for index in stride(from: 0, to: inputArray.count, by: 1) {
            if index == 0 {
                
                for jindex in stride(from: 0, to: inputArray[index].count, by: 1) {
                    inputArray[index][jindex].position.x = -circuitNode.size.width/2 + inputArray[index][jindex].size.width
                }
                
            }else {
                    
                    for jindex in stride(from: 0, to: inputArray[index].count, by: 1) {
//                        inputArray[index][jindex].position.x = -circuitNode.size.width/2 + inputArray[index][jindex].size.width
                        inputArray[index][jindex].position.x = (inputArray[index - 1][0].position.x) + (inputArray[index - 1][0].size.width/2) + inputArray[index][jindex].size.width/2

                    }
                }
            }
        }
    
        
        //    lazy var firstColumnOffsetX: Double = {
        //        return Double(-circuitNode.size.width/2 + firstColumn1Grass.size.width/2)
        //    }()
        //
        //    lazy var secondColumnOffsetX: Double = {
        //        return Double(firstColumnOffsetX + firstColumn1Grass.size.width/2 + secondColumn1Grass.size.width/2)
        //    }()
        //
        //    lazy var thirdColumnOffsetX: Double = {
        //        return Double(secondColumnOffsetX + secondColumn1Grass.size.width/2 + thirdColumn1Grass.size.width/2)
        //    }()
        
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
