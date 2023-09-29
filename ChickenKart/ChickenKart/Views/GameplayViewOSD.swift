//
//  GameplayView.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 29/09/23.
//

import SwiftUI
import SpriteKit

struct GameplayViewOSD: View {
    
    @State var angleDeg: Double = 0
    @State var offSetX: Double = 0
    @State var offSetY: Double = 0
    
    @State var offSetXValue: Double = 0
    @State var offSetYValue: Double = 15
    
    @State var secondsTimer: Double = 15
    
    @StateObject var timer = RaceTimer()
    
    
    var body: some View {
        
        var scene: GameSceneOSD {
            let scene = GameSceneOSD()
            scene.backgroundColor = UIColor(red: 0.106, green: 0.686, blue: 0.306, alpha: 1) // #1baf4e
            
            scene.size = CGSize(width: 520, height: 450)

            scene.scaleMode = .aspectFill
            return scene
        }
        
        ZStack {
            
            ZStack {
                
                SpriteView(scene: scene, debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics])

            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    PlayerView()
                    Spacer()
                    
                }
                .offset(y: -40)
            }
            VStack{
                Spacer(minLength: CGFloat(2))
                Hud(time: Int(timer.seconds), speed: 1234)
            }

        }
        .onAppear(perform: timer.startTimer)
        .onDisappear(perform: timer.stopTimer)
    }
}

struct GameplayViewOSD_Previews: PreviewProvider {
    static var previews: some View {
        GameplayViewOSD()
    }
}
