//
//  GameScene.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//


import SwiftUI
import GameController
import CoreMotion
import SpriteKit

class GameScene: SKScene {
    
    private var motionManager = CMMotionManager()
    
    var turnOfGround: Double = 0.0
    
    let motionQueue = OperationQueue()
    let ground  = SKSpriteNode(imageNamed: "circuit")
    let kart = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
    }

    override func didMove(to view: SKView) {
        self.removeAllChildren()
        createBackground()
        createKart()
        motionBackground()
    }

    private func createBackground() {
        ground.name = "ground"
        ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.width)!)
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(ground)
    }
    
    private func createKart() {
        kart.name = "kart"
        kart.strokeColor = SKColor.yellow
        kart.lineWidth = 10
        kart.position = CGPoint(x: -100, y: 0)
        kart.zPosition = 1
        self.addChild(kart)
    }
    
    
    private func motionBackground() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.001
            motionManager.startGyroUpdates(to: motionQueue) { data, _ in
                if let rotationRate = data?.rotationRate {
                    DispatchQueue.main.async {
                        self.ground.zRotation -= (rotationRate.z / 75)
                        self.turnOfGround -= (rotationRate.z / 10)
                        
                        if self.turnOfGround > 0.0 {
                            self.ground.position.x -= 0.5
                            if self.turnOfGround < 4 {
                                self.ground.position.y -= 0.5
                            }
                            else {
                                self.ground.position.y += 0.5
                            }
                        }
                        else {
                            self.ground.position.x += 0.5
                            if self.turnOfGround > -4 {
                                self.ground.position.y -= 0.5
                            }
                            else {
                                self.ground.position.y += 0.5
                            }
                        }

                    }
                }
            }
            
        }
    }
}
