//
//  ContentView.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 25/09/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State var gameStarted: Bool = false
    
    
    var body: some View {
        
        if !gameStarted {
            TitleScreen()
                .onTapGesture {
                    gameStarted = true
                }
        } else {
            GameplayView()
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
