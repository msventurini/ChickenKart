//
//  Crowd.swift
//  ChickenKart
//
//  Created by Fernanda de Castro Teixeira on 27/09/23.
//

import Foundation
import SpriteKit

// This enum lets you easily switch between animations
enum PlayerAnimationType: String {
    case walk
}

class Crowd: SKSpriteNode {
  // MARK: - PROPERTIES
    
    // Textures (Animation)
    private var walkTextures: [SKTexture]?
    
    init() {
    
        // Set default texture
    let texture = SKTexture(imageNamed: "catWalk1")
        
    // Call to super.init
    super.init(texture: texture, color: .clear, size: texture.size())
    
    // Set up animation textures
    self.walkTextures = self.loadTextures(atlas: "walk", prefix: "catWalk", startsAt: 1, stopsAt: 4)
    
        // Set up other properties after init
    self.name = "player"
    self.setScale(1.0)
    self.anchorPoint = CGPoint(x: 0.5, y: 0.0) // center-bottom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  // MARK: - INIT
    
    
    
  // MARK: - METHODS
    
    func moveToPosition(pos: CGPoint, speed: TimeInterval) {
        let moveAction = SKAction.move(to: pos, duration: speed)
        run(moveAction)
    }
    
    func walk() {
        
        // Check for textures
        guard let walkTextures = walkTextures else {
            preconditionFailure("Could not find textures!") }
        
        // Run animation (forever)
        startAnimation(textures: walkTextures, speed: 0.25, name: PlayerAnimationType.walk.rawValue,
                       count: 0, resize: true, restore: true)
    }
}
