//
//  ContentView.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        
        var scene: GameScene {
            let scene = GameScene()
            scene.size = CGSize(width: 200, height: 200)
            scene.scaleMode = .aspectFit
            return scene
        }
        
        VStack {
            SpriteView(scene: scene)
            
            MotionBasicsView()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
