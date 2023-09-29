//
//  TitleScreen.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 29/09/23.
//

import SwiftUI

struct TitleScreen: View {
    var body: some View {
        
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
                Image("start")
                Image("continue")
            }
            
            

        }
        
        
        
        
        

        
        
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreen()
    }
}
