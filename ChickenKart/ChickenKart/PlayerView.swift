//
//  PlayerView.swift
//  ChickenKart
//
//  Created by Matheus Silveira Venturini on 27/09/23.
//

import SwiftUI

struct PlayerView: View {
    var body: some View {
        
        ZStack(alignment: .bottom) {
//            Rectangle()

            Image("galiBack")
                .resizable()
                .scaledToFit()
//                .frame(width: 370)
            

            Image("carBack")
                .resizable()
                .scaledToFit()
//                .frame(width: 390)

            
        }
        .frame(width: 100)
        
        
            
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
