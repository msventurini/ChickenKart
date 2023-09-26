//
//  ContentView.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SwiftUI
import SpriteKit



struct rotationState {
    
}

struct ContentView: View {
    
    @State var angleDeg: Double = 0
    @State var offSetX: Double = 0
    @State var offSetY: Double = 0
    
    @State var offSetXValue: Double = 0
    @State var offSetYValue: Double = 15
    
//    @State

    
    var body: some View {
        
//        var scene: GameScene {
//            let scene = GameScene()
//            scene.scaleMode = .aspectFill
//            return scene
//        }
//
//        ZStack(alignment: .bottom) {
//            SpriteView(scene: scene)
//
//            VStack {
//
//                MotionBasicsView()
//
//            }
//            .frame(height: 100)
//
//
//
//        }
//        .edgesIgnoringSafeArea(.all)
        
        ZStack {
            Image("circuit")
                .offset(x: offSetX, y: offSetY)
                .scaleEffect(10)
            
                .rotation3DEffect(Angle(degrees: angleDeg), axis: (x: 0.0, y: 0.0, z: 1.0))
                .rotation3DEffect(Angle(degrees: 85), axis: (x: 1.0, y: 0.0, z: 0.0))
            HStack {
                Rectangle()
                    .overlay(content: {
                        Text("left")
                            .colorInvert()
                    })
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation {
                            angleDeg -= 15
                        }
                    }
                
                
                Rectangle()
                    .overlay(content: {
                        Text("up")
                            .colorInvert()
                    })
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation {
                            offSetY += 15 * cos(angleDeg)
//                            offSetX -= 15 * sin(angleDeg)
                        }
                    }
                
                Rectangle()
                    .overlay(content: {
                        Text("down")
                            .colorInvert()
                    })
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation {
                            offSetY -= 15
                        }
                    }
                
                
                
                Rectangle()
                    .overlay(content: {
                        Text("right")
                            .colorInvert()
                    })
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation {
                            angleDeg += 15
                        }
                    }
                
            }
            .offset(y: 100)
            
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
