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
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        backgroundColor = .purple
    }
    
    override func didMove(to view: SKView) {
        self.removeAllChildren()
    }
    
}
