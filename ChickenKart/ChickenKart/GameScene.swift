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
    let circuitNode = SKTransformNode()

    var vectorGravity = CGVector(dx: 0, dy: -2.0)
    
    var virtualController: GCVirtualController?


    
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
        self.removeAllChildren()
        setupVirtualController()
        
        
        let player = SKSpriteNode(color: .red, size: .init(width: 10, height: 10))
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.name = "player"

        
        let ground = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))
        
        
        ground.position = CGPoint(x: size.width/2, y: ground.size.height/2)
        ground.name = "ground"
        
        
        
        circuitNode.position = CGPoint(x: player.position.x - 20, y: player.position.y - 20)

        circuitNode.addChild(ground)
        
        let ceil = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))

        ceil.position = CGPoint(x: size.width/2, y: self.size.height - 5)
        ceil.name = "ceil"


        circuitNode.addChild(ceil)

        let wall1 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall1.position = CGPoint(x: 5, y: size.height / 2)
        wall1.name = "wall"



        circuitNode.addChild(wall1)


        let wall2 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall2.position = CGPoint(x: size.width - 5, y: size.height / 2)
        wall2.name = "wall"

        circuitNode.addChild(wall2)
        
        let center = SKSpriteNode(color: .brown, size: .init(width: 85, height: 85))
        center.position = CGPoint(x: size.width/2, y: size.height/2)
        center.name = "center"
        

        circuitNode.name = "circuit"
        circuitNode.addChild(center)

        
        self.addChild(circuitNode)
        
        
        
        


        
        self.addChild(player)

        
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
                self.circuitNode.zRotation -= CGFloat(Double.pi / 180)
            }
            
        }
        right.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("direito")
                self.circuitNode.zRotation += CGFloat(Double.pi / 180)

            }
            
        }
        up.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("cima")
                self.circuitNode.position.y += 1

            }
            
        }
        down.pressedChangedHandler = { button, value, pressed in
            if pressed {
                print("baixo")
                self.circuitNode.position.y -= 1

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
