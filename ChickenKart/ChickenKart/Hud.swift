//
//  Hud.swift
//  ChickenKart
//
//  Created by Raquel Ramos on 28/09/23.
//

import SwiftUI

struct Hud: View {
    //enviar o tempo por aqui
    var time: Int
    var speed: Double
    var score: Int = 1000
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .frame(width: 520, height: 90)
            HStack(spacing: 51) {
                //speed
                VStack {
                    Text("speed")
                    Text("\(Int(speed * 1000)) km/h")
                        .foregroundColor(.yellow)
                        
                }
                
                //time
                VStack {
                    Text("time")
                    Text("\(time)")
                        .foregroundColor(.yellow)
                }
                
                //score
                VStack{
                    Text("score")
                    Text("\(score - time * 2)")
                        .foregroundColor(.yellow)
                }
                
                //pista (isso é contigo, Matheus)
                
            }
        }
        .foregroundColor(.white)
        .font(.custom("DotGothic16-Regular", fixedSize: 23))
        
        
    }
}

struct Hud_Previews: PreviewProvider {
    static var previews: some View {
        Hud(time: 0, speed: 0.0)
    }
}
