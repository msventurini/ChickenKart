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
    
//    @State

    
    var body: some View {
        
        var scene: GameScene {
            let scene = GameScene()
            
            
            scene.size = CGSize(width: 520, height: 450)

            scene.scaleMode = .aspectFill
            return scene
        }

        ZStack {
            
            ZStack {
                
                
                SpriteView(scene: scene, debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics])
//                    .rotationEffect(Angle(degrees: 90.0))
//                    .frame(width: 520, height: 450)
                
            }
            .ignoresSafeArea()

//            VStack {
//                HStack {
//                    Spacer()
//                    PlayerView()
//                    Spacer()
//
//                }
//                .offset(y: -50)
//            }
            
            
            
                

//            VStack {
//
//                MotionBasicsView()
//
//            }
//            .frame(height: 100)



        }
//        .edgesIgnoringSafeArea(.all)
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
