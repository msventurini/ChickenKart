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
    
//    let circuitTexture = SKTexture(imageNamed: "circuit")
    let circuitNode = SKNode()

    var vectorGravity = CGVector(dx: 0, dy: -2.0)

    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = self.vectorGravity
        
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

//        let circuitNode = SKNode()
        
        let ground = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))
        
//        let ground = SKShapeNode(rect: CGRect(x: Int, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>))
        
        ground.position = CGPoint(x: size.width/2, y: ground.size.height/2)
        ground.name = "ground"
        
        
        let bodyGround = SKPhysicsBody(rectangleOf: ground.size)
        bodyGround.affectedByGravity = true
        bodyGround.allowsRotation = false
        bodyGround.isDynamic = false
        
        bodyGround.contactTestBitMask = 1
        
        ground.physicsBody = bodyGround
        
//        self.addChild(ground)
        circuitNode.addChild(ground)
        
        let ceil = SKSpriteNode(color: .brown, size: .init(width: 160, height: 10))

        ceil.position = CGPoint(x: size.width/2, y: self.size.height - 5)
        ceil.name = "ceil"

        let bodyCeil = SKPhysicsBody(rectangleOf: ceil.size)
        bodyCeil.affectedByGravity = true
        bodyCeil.allowsRotation = false
        bodyCeil.isDynamic = false

        bodyCeil.contactTestBitMask = 1

        ceil.physicsBody = bodyCeil

//        self.addChild(ceil)
        circuitNode.addChild(ceil)

        let wall1 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall1.position = CGPoint(x: 5, y: size.height / 2)
        wall1.name = "wall"

        let wallBody1 = SKPhysicsBody(rectangleOf: wall1.size)
        wallBody1.affectedByGravity = true
        wallBody1.allowsRotation = false
        wallBody1.isDynamic = false

        wall1.physicsBody = wallBody1

//        self.addChild(wall1)
        circuitNode.addChild(wall1)


        let wall2 = SKSpriteNode(color: .brown, size: .init(width: 10, height: 144))
        wall2.position = CGPoint(x: size.width - 5, y: size.height / 2)
        wall2.name = "wall"

        let wallBody2 = SKPhysicsBody(rectangleOf: wall2.size)
        wallBody2.affectedByGravity = true
        wallBody2.allowsRotation = false
        wallBody2.isDynamic = false

        wall2.physicsBody = wallBody2

//        self.addChild(wall2)
        circuitNode.addChild(wall2)
        
        let center = SKSpriteNode(color: .brown, size: .init(width: 85, height: 85))
        center.position = CGPoint(x: size.width/2, y: size.height/2)
        center.name = "center"
        
        let centerBody = SKPhysicsBody(rectangleOf: center.size)

        centerBody.affectedByGravity = true
        centerBody.allowsRotation = false
        centerBody.isDynamic = false

        center.physicsBody = centerBody
        
//        self.addChild(center)
        circuitNode.addChild(center)
//        circuitNode.scene?.anchorPoint
        
        self.addChild(circuitNode)
        
        
        let player = SKSpriteNode(color: .red, size: .init(width: 10, height: 10))
        player.position = CGPoint(x: 20, y: 20)
        player.name = "player"
        
        let playerBody = SKPhysicsBody(rectangleOf: player.size)
        playerBody.affectedByGravity = false
        playerBody.allowsRotation = false
        playerBody.isDynamic = false
        
        player.physicsBody = playerBody

        
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
    
}
