//
//  ContentView.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State var angleDeg: Double = 0
    @State var offSetX: Double = 0
    @State var offSetY: Double = 0
    
    @State var offSetXValue: Double = 0
    @State var offSetYValue: Double = 15
    
    @State var secondsTimer: Double = 15
    
    @StateObject var timer = RaceTimer()
    
    var body: some View {
        
        var scene: GameScene {
            let scene = GameScene()
            
            
            scene.size = CGSize(width: 520, height: 450)
            
            scene.scaleMode = .aspectFit
            return scene
        }
        
        ZStack {
            
            ZStack {
                
                SpriteView(scene: scene, debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics])
                
                
            }.frame(width: 520, height: 450)
            
            VStack {
                HStack {
                    Spacer()
                    PlayerView()
                    Spacer()
                    
                }
                .offset(y: -50)
            }
            HStack{
                Text("\(timer.seconds)")
                    .foregroundColor(.red)
                Spacer()
            }
        }
        .onAppear(perform: timer.startTimer)
        .onDisappear(perform: timer.stopTimer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
