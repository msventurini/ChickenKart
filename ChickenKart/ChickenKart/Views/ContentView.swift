//
//  ContentView.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    
    
    @State var motionClicked: Bool = false
    @State var displayClicked: Bool = false
    
    var gameStarted: Bool {
        return (motionClicked || displayClicked)
    }
    
    var body: some View {
        
        if !gameStarted {
            
            ZStack {
                Rectangle()
                    .fill(Color.black)
                VStack (spacing: 30) {
                    ZStack {
                        VStack {
                            Spacer()
                            Image("Rectangle")
            //
                        }
                        VStack {
                            Image("cocori")
                            Image("Kart")
                            Spacer()
                        }
                    }
                    .aspectRatio(CGSize(width: 140, height: 180),contentMode: .fit)
                    .frame(height: 140)
                    .background(Color.black)
                    Group {
                        Text("Motion Controls")
                            .onTapGesture {
                                motionClicked = true
                                displayClicked = false
                            }
                        Text("On-display Controll")
                            .onTapGesture {
                                displayClicked = true
                                motionClicked = false
                            }
                    }
                    .foregroundColor(.white)
                    
                }
                
                

            }
                
        } else if displayClicked {
            GameplayViewOSD()
        } else if motionClicked {
            GameplayView()
        }
        
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
