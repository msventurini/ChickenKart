//
//  GameScene.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SpriteKit
import SwiftUI
import GameController

class GameScene: SKScene {
    
//    let circuitTexture = SKTexture(imageNamed: "circuit")
    let circuitNode = SKNode()

    var vectorGravity = CGVector(dx: 0, dy: -2.0)
    
    var virtualController: GCVirtualController?


    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        
//        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        self.circuitNode.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.circuitNode.position = CGPoint(x: -size.width/2, y: -size.height/2)
//        backgroundColor = .purple
    }
    
//    override func update(_ currentTime: TimeInterval) {
////        circuitNode.zRotation += 0.1
//    }
    
    override func didMove(to view: SKView) {
        self.removeAllChildren()
        setupVirtualController()

//        let circuitNode = SKNode()
        
        let ground = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))
        
//        let ground = SKShapeNode(rect: CGRect(x: Int, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>))
        
        ground.position = CGPoint(x: size.width/2, y: ground.size.height/2)
        ground.name = "ground"
        
        
        
        
//        self.addChild(ground)
        circuitNode.addChild(ground)
        
        let ceil = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))

        ceil.position = CGPoint(x: size.width/2, y: self.size.height - 5)
        ceil.name = "ceil"


//        self.addChild(ceil)
        circuitNode.addChild(ceil)

        let wall1 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall1.position = CGPoint(x: 5, y: size.height / 2)
        wall1.name = "wall"



//        self.addChild(wall1)
        circuitNode.addChild(wall1)


        let wall2 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall2.position = CGPoint(x: size.width - 5, y: size.height / 2)
        wall2.name = "wall"

//        self.addChild(wall2)
        circuitNode.addChild(wall2)
        
        let center = SKSpriteNode(color: .brown, size: .init(width: 85, height: 85))
        center.position = CGPoint(x: size.width/2, y: size.height/2)
        center.name = "center"
        

        circuitNode.name = "circuit"
//        self.addChild(center)
        circuitNode.addChild(center)
//        circuitNode.scene?.anchorPoint
        
        self.addChild(circuitNode)
        
        
        let player = SKSpriteNode(color: .red, size: .init(width: 10, height: 10))
        player.position = CGPoint(x: 20, y: 20)
        player.name = "player"
        


        
        self.addChild(player)
//        circuitNode.zRotation = 32
        
//        zRotationCircuit = SKAction.rotate(byAngle: 1, duration: 0)
//
//        circuitNode.run(zRotation) {
//            scene?.view?.presentScene(newScene)
//        }
//        let componentArray = [ground, wall1, wall2, ceil, center]
        
//        for i in stride(from: 0, to: componentArray.count, by: 1) {
//            componentArray[i].zRotation += 1
//        }
        
        
    }
    
    
    func setupVirtualController() {
        let virtualControllerConfig = GCVirtualController.Configuration()
        virtualControllerConfig.elements = [GCInputLeftThumbstick, GCInputButtonA, GCInputButtonB]
        
        virtualController = GCVirtualController(configuration: virtualControllerConfig)
        
        virtualController!.connect()
        
        getInput()
        
    }
    
    func getInput() {
        var jumpButton: GCControllerButtonInput?
        var actionButton: GCControllerButtonInput?
        var stickXAxis: GCControllerAxisInput?
        
        if let buttons = virtualController!.controller?.extendedGamepad {
            jumpButton = buttons.buttonA
            actionButton = buttons.buttonB
            stickXAxis = buttons.leftThumbstick.xAxis
        }
        
        stickXAxis?.valueChangedHandler  = {(_ button: GCControllerAxisInput, _ value: Float) -> Void in
            print(value)
//            self.player.velocityX = -value //conferir o pq deste negativo depois
            self.circuitNode.position.x += CGFloat(value)
            if value == 0.0 {
                self.circuitNode.removeAllActions()
            }
        }
        
        //está sendo acionado tanto quando pressionamos como quando terminamos de pressionar, consertar isso
        jumpButton?.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            
            if pressed {
//                self.player.jump()
                print("Button A Pressed")
            }
            
            
        }
        
        actionButton?.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            if pressed {
                print("Button B Pressed")
            }
            
        }
        
    }
    
    
}
