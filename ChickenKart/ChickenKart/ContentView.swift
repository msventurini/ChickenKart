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
            scene.scaleMode = .aspectFill
            return scene
        }
        
        ZStack(alignment: .bottom) {
            SpriteView(scene: scene)
            
            VStack {
                
                MotionBasicsView()
                
            }
            .frame(height: 100)
            
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
