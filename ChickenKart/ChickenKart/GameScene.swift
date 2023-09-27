//
//  GameScene.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SpriteKit
import SwiftUI
import GameController

enum Direction {
    case w
    case nw
    case n
    case no
    case o
    
    case so
    case s
    case sw
    
    
    var turnRight: Direction {
        switch self {
        case .w:
            return .nw
        case .nw:
            return .n
        case .n:
            return .no
        case .no:
            return .o
        case .o:
            return .so
        case .so:
            return .s
        case .s:
            return .sw
        case .sw:
            return .w
        }
    }
    
    var turnLeft: Direction {
        switch self {
        case .w:
            return .sw
        case .nw:
            return .w
        case .n:
            return .nw
        case .no:
            return .n
        case .o:
            return .no
        case .so:
            return .o
        case .s:
            return .so
        case .sw:
            return .s
        }
    }
    
    var offsetX: Double {
        switch self {
        case .w:
            return -1
        case .nw:
            return -0.7
        case .n:
            return 0
        case .no:
            return 0.7
        case .o:
            return 1
        case .so:
            return 0.7
        case .s:
            return 0
        case .sw:
            return -0.7
        }
    }
    
    var offsetY: Double {
        switch self {
        case .w:
            return 0
        case .nw:
            return 0.7
        case .n:
            return 1
        case .no:
            return 0.7
        case .o:
            return 0
        case .so:
            return -0.7
        case .s:
            return -1
        case .sw:
            return -0.7
        }
    }
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //    let circuitTexture = SKTexture(imageNamed: "circuit")
    
    var player = SKNode()
    
    var playerSprite = SKSpriteNode()
    
    var circuitNode = SKSpriteNode()
    
    var vectorGravity = CGVector(dx: 0, dy: -2.0)
    
    var virtualController: GCVirtualController?
    
    var direction: Direction = .n
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        
        //        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //        self.circuitNode.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //        self.circuitNode.position = CGPoint(x: -size.width/2, y: -size.height/2)
        //        backgroundColor = .purple
    }
    
    //    override func update(_ currentTime: TimeInterval) {
    ////        circuitNode.zRotation += 0.1
    //    }
    
    override func didMove(to view: SKView) {
        //        self.removeAllChildren()
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        
        
        setupVirtualController()
        
        
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        
        circuitNode = SKSpriteNode(color: .blue, size: .init(width: 160, height: 144))
        circuitNode.anchorPoint = CGPoint(x: 0, y: 0)
        circuitNode.position = CGPoint(x: -20, y: -20)
        
        
        let ground = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))
        
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        ground.position = CGPoint(x: circuitNode.frame.minX + 20, y: circuitNode.frame.minY + 20)
        ground.name = "ground"
        
        
        
        circuitNode.addChild(ground)
        
        let ceil = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))
        ceil.anchorPoint = CGPoint(x: 0, y: 0)
        ceil.position = CGPoint(x: circuitNode.frame.minX + 20, y: circuitNode.frame.maxY + 20)
        ceil.name = "ceil"
        
        
        circuitNode.addChild(ceil)
        
        let wall1 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall1.anchorPoint = CGPoint(x: 0, y: 0)
        wall1.position = CGPoint(x: circuitNode.frame.maxX + 20, y: circuitNode.frame.minY + 20)
        wall1.name = "wall"
        
        
        
        circuitNode.addChild(wall1)
        
        
        let wall2 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall2.anchorPoint = CGPoint(x: 0, y: 0)
        wall2.position = CGPoint(x: circuitNode.frame.minX + 20, y: circuitNode.frame.minY + 20)
        wall2.name = "wall"
        
        circuitNode.addChild(wall2)
        
        let center = SKSpriteNode(color: .brown, size: .init(width: 85, height: 85))
        center.anchorPoint = CGPoint(x: 0, y: 0)
        center.position = CGPoint(x: circuitNode.frame.midX + 20, y: circuitNode.frame.midY - 20)
        center.name = "center"
        
        
        circuitNode.name = "circuit"
        
        circuitNode.addChild(center)
        
        
        player.addChild(circuitNode)
        
        
        
        
        let playerSprite = SKSpriteNode(color: .red, size: .init(width: 10, height: 10))
        //        player.position = CGPoint(x: size.width/2, y: size.height/2)
        playerSprite.name = "player"
        
        
        
        player.addChild(playerSprite)
        
        
    }
    
    
    func setupVirtualController() {
        let virtualControllerConfig = GCVirtualController.Configuration()
        virtualControllerConfig.elements = [GCInputDirectionPad, GCInputButtonA, GCInputButtonB]
        
        virtualController = GCVirtualController(configuration: virtualControllerConfig)
        
        virtualController!.connect()
        
        getInput()
        
    }
    
    func getInput() {
        
        
        //        var jumpButton: GCControllerButtonInput?
        //        var actionButton: GCControllerButtonInput?
        //        var left: GCControllerButtonInput?
        //        var right: GCControllerButtonInput?
        //        var up: GCControllerButtonInput?
        //        var down: GCControllerButtonInput?
        //        var stickYAxis: GCControllerAxisInput?
        
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
                self.player.zRotation -= CGFloat(Angle(degrees: 45).radians)
                self.direction = self.direction.turnLeft
                print("\(self.direction)")
                
                //                for i in stride(from: 0, to: self.circuitNode.children.count, by: 1) {
                //                    self.circuitNode.children[i].zRotation -= CGFloat(Double.pi / 180)
                //                }
                
            }
            
        }
        right.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("direito")
                self.player.zRotation += CGFloat(Angle(degrees: 45).radians)
                self.direction = self.direction.turnRight
                print("\(self.direction)")
                
                //                for i in stride(from: 0, to: self.circuitNode.children.count, by: 1) {
                //                    self.circuitNode.children[i].zRotation += CGFloat(Double.pi / 180)
                //                }
                
            }
            
        }
        up.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("cima")
                self.circuitNode.position.x -= self.direction.offsetX * 3
                self.circuitNode.position.y -= self.direction.offsetY * 3
                
                
            }
            
        }
        down.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("baixo")
                self.circuitNode.position.x += self.direction.offsetX * 3
                self.circuitNode.position.y += self.direction.offsetY * 3
                
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
