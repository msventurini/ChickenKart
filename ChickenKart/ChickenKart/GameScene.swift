//
//  GameScene.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SpriteKit
import SwiftUI
import GameController


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var player = SKTransformNode()
    
    var playerSprite = SKSpriteNode()
    
    var circuitNode = SKSpriteNode()
    
    var vectorGravity = CGVector(dx: 0, dy: -2.0)
    
    var virtualController: GCVirtualController?
        
    var angle: Double = 0
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setupVirtualController()

    }

    
    override func didMove(to view: SKView) {
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        getInput()

        player.position = CGPoint(x: frame.midX, y: frame.midY)
        
        circuitNode = SKSpriteNode(color: .brown, size: .init(width: 520, height: 450))
        circuitNode.anchorPoint = CGPoint(x: 0, y: 0)
//        circuitNode.position = CGPoint(x: -20, y: -20)
        
        let ground = SKSpriteNode(imageNamed: "circuitpt1")
        
        ground.anchorPoint = CGPoint(x: 0.5, y: 0)
        ground.position = CGPoint(x: circuitNode.frame.midX, y: circuitNode.frame.minY)
        ground.name = "ground"

//        let groundBody = SKPhysicsBody(edgeLoopFrom: ground.frame)
//        ground.physicsBody = groundBody
//
        
        circuitNode.addChild(ground)
//
        let ceil = SKSpriteNode(imageNamed: "circuitpt2")
        ceil.anchorPoint = CGPoint(x: 0, y: 1)
        ceil.position = CGPoint(x: circuitNode.frame.minX, y: circuitNode.frame.maxY)
        ceil.name = "ceil"

        circuitNode.addChild(ceil)

        circuitNode.name = "circuit"
        
        
        
        player.addChild(circuitNode)

        let playerSprite = SKSpriteNode(color: .clear, size: .init(width: 10, height: 10))
        playerSprite.name = "player"
        
//        let playerBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
//        
//        playerBody.affectedByGravity = true
//        playerBody.allowsRotation = true
//        playerBody.isDynamic = true
////        playerBody.velocity = CGVector(dx: 0, dy: 10.0)
//        
//        playerSprite.physicsBody = playerBody
//        bodyGround.contactTestBitMask = 1
                
        player.addChild(playerSprite)
        
        player.xRotation = Angle(degrees: 85).radians
        
        player.setScale(CGFloat(15))
    }
    
    
    func setupVirtualController() {
        let virtualControllerConfig = GCVirtualController.Configuration()
        virtualControllerConfig.elements = [GCInputDirectionPad, GCInputButtonA, GCInputButtonB]
        
        virtualController = GCVirtualController(configuration: virtualControllerConfig)
        
        virtualController!.connect()
        
        
    }
    
    func getInput() {
        
        guard let buttons = virtualController!.controller?.extendedGamepad else { return }
        
        let breakButton = buttons.buttonB
        let speedButton = buttons.buttonA
        let left = buttons.dpad.left
        let right = buttons.dpad.right
        let up = buttons.dpad.up
        let down = buttons.dpad.down
        
        left.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("esquerdo")
                
                self.angle += 0.5 * 10
                
                self.player.zRotation = CGFloat(Angle(degrees: self.angle).radians)

            }
            
        }
        right.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("direito")
                self.angle -= 0.5 * 10

                
                self.player.zRotation = CGFloat(Angle(degrees: self.angle).radians)

            }
            
        }
        up.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("cima")
                self.circuitNode.position.x +=  sin(Angle(degrees: self.angle).radians) * 10
                self.circuitNode.position.y -=  cos(Angle(degrees: self.angle).radians) * 10
                
                
            }
            
        }
        down.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("baixo")
                self.circuitNode.position.x -=  sin(Angle(degrees: self.angle).radians) * 10
                self.circuitNode.position.y +=  cos(Angle(degrees: self.angle).radians) * 10
                
            }
            
        }
        
        breakButton.pressedChangedHandler = { button, value, pressed in
            
            if pressed {
                print("break Pressed")
            }
            
            
        }
        
        speedButton.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("speed Pressed")
            }
            
        }
        
    }
    
    
}
