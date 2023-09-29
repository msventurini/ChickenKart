//
//  Sounds.swift
//  ChickenKart
//
//  Created by Raquel Ramos on 28/09/23.
//

import Foundation
import AVFoundation

class SoundManager: ObservableObject {
    var sound: AVAudioPlayer?
    
    func playSound(name: SoundCases) {
        let url = Bundle.main.path(forResource: name.chosenSound, ofType: "m4a")
        do {
            sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            sound?.play()
        } catch {
            print("não encontrei o som")
        }

        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch let error {
            print(error)
            print("não tocou o som")
        }
    }
    
}

enum SoundCases {
    case start, celebration, crash
    
    var chosenSound: String {
        switch self {
        case .start:
            return "start"
        case .celebration:
            return "celebration"
        case .crash:
            return "crash"
        default:
            return "chickenDefault"
            
        }
        
    }
}
